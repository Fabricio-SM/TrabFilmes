// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/comment.dart';
import 'package:flutter_application_1/services/notification_service.dart';
import '../services/comment_service.dart';
import 'package:flutter_application_1/styles.dart';

class EditPost extends StatefulWidget {
  final String commId;
  final Comment comentario;
  const EditPost({super.key, required this.commId, required this.comentario});

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  bool isEditing = false;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController imgController = TextEditingController();
  final TextEditingController commController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final txt = TextStyles();
    final mediaQuery = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Editar/Deletar Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 5,
            ),
            isEditing
                ? TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: widget.comentario.titulo,
                      filled: true,
                      fillColor: const Color.fromARGB(255, 255, 255, 255),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  )
                : Text(
                    '"${widget.comentario.titulo}"',
                    style: txt.titulo,
                  ),
            isEditing
                ? TextFormField(
                    controller: imgController,
                    decoration: InputDecoration(
                      labelText: widget.comentario.imgUrl,
                      filled: true,
                      fillColor: const Color.fromARGB(255, 255, 255, 255),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  )
                : Image.network(
                    widget.comentario.imgUrl,
                    height: mediaQuery.height / 5,
                    width: mediaQuery.width / 2,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return const Icon(
                        Icons.no_photography_outlined,
                      );
                    },
                  ),
            isEditing
                ? TextFormField(
                    controller: commController,
                    maxLines: 6,
                    decoration: InputDecoration(
                      labelText: widget.comentario.conteudo,
                      filled: true,
                      fillColor: const Color.fromARGB(255, 255, 255, 255),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  )
                : Text(widget.comentario.conteudo),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (isEditing)
                  ElevatedButton(
                    onPressed: () {
                      var comentario = Comment(
                          id: widget.comentario.id,
                          titulo: titleController.text,
                          // titleController.text == null ? widget.comentario.conteudo : titleController.text,
                          imgUrl: imgController.text,
                          conteudo: commController.text);

                      attComment(widget.commId, comentario);
                      setState(() {
                        isEditing = false;
                      });
                    },
                    child: Text('Salvar alterações'),
                  ),
                if (!isEditing)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isEditing = true;
                      });
                    },
                    child: Text('Editar dados'),
                  ),
                ElevatedButton(
                  onPressed: () {
                    deleteComment(widget.commId);
                    NotificationService.showNotification(
                    "Remoção de comentários", "Comentário removido.");
                    Navigator.pop(context);
                  },
                  child: Text('Excluir comentário'),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

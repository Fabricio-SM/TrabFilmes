// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/id_create.dart';

import '../model/comment.dart';
import '../services/comment_service.dart';
import '../services/notification_service.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController imgController = TextEditingController();
  final TextEditingController commController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Criar Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Título do comentário',
                filled: true,
                fillColor: const Color.fromARGB(255, 255, 255, 255),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                      color: const Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
            ),
            TextFormField(
              controller: imgController,
              decoration: InputDecoration(
                labelText: 'Insira a URL da imagem',
                filled: true,
                fillColor: const Color.fromARGB(255, 255, 255, 255),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                      color: const Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
            ),
            TextFormField(
              controller: commController,
              maxLines: 6,
              decoration: InputDecoration(
                labelText: 'Comentário',
                filled: true,
                fillColor: const Color.fromARGB(255, 255, 255, 255),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                      color: const Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                postComm(
                  Comment(
                      id: generateRandomId(),
                      titulo: titleController.text,
                      imgUrl: imgController.text,
                      conteudo: commController.text),
                );
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Comentário criado com sucesso!!"),
                    duration: Duration(seconds: 5),
                  ),
                );
                NotificationService.showNotification(
                    "Adição de comentários", "Comentário ${titleController.text} adicionado.");
              },
              child: Text('Publicar'),
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

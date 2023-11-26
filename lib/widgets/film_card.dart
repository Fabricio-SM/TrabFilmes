// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/comment.dart';
import 'package:flutter_application_1/routes/edit_post_page.dart';
import 'package:flutter_application_1/styles.dart';

class FilmCard extends StatelessWidget {
  final Comment comment;
  final int index;

  const FilmCard({super.key, required this.comment, required this.index});

  @override
  Widget build(BuildContext context) {
    final txt = TextStyles();
    final mediaQuery = MediaQuery.sizeOf(context);
    return Material(
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
      elevation: 60,
      child: Container(
        height: mediaQuery.height / 2,
        width: mediaQuery.width / 2,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 0.5),
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(0, 240, 213, 213),
        ),
        child: Column(
          children: [
            Text(
              '"${comment.titulo}"',
              style: txt.titulo,
              textAlign: TextAlign.center,
            ),
            Image.network(
              comment.imgUrl,
              height: mediaQuery.height / 5,
              width: mediaQuery.width / 2,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return const Icon(
                  Icons.no_photography_outlined,
                );
              },
            ),
            Text(comment.conteudo),
          ],
        ),
      ),
    );
  }
}

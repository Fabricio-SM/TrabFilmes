
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/comment.dart';
import 'package:flutter_application_1/routes/create_post.dart';
import 'package:flutter_application_1/widgets/film_card.dart';
import 'package:flutter_application_1/providers/perfil_cache.dart';
import 'package:provider/provider.dart';
import '../services/comment_service.dart';
import 'edit_post_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _PostMenuState();
}

class _PostMenuState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Cache>(
      builder: (context, cache, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Posts"),
          ),
          backgroundColor: const Color.fromARGB(0, 236, 233, 248),
          body: CommentListWidget(),
          floatingActionButton: FloatingActionButton(
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreatePost()),
            ),
          ),
        );
      },
    );
  }
}

class CommentListWidget extends StatelessWidget {
  const CommentListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 10),
      width: 1080,
      decoration: BoxDecoration(
          color: const Color.fromARGB(236, 247, 239, 239),
          borderRadius: BorderRadius.circular(30)),
      child: FutureBuilder<List<Comment>>(
        future: fetchComm(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else {
            final List<Comment> movies = snapshot.data!;
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: FilmCard(comment: movies[index], index: index),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditPost(
                        commId: movies[index].id,
                        comentario: movies[index],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

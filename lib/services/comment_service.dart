import 'dart:convert';
import 'package:flutter_application_1/model/comment.dart';
import 'package:http/http.dart' as http;

const String Url = 'http://192.168.0.106:5000/posts';

Future<List<Comment>> fetchComm() async {
  final response = await http.get(Uri.parse(Url));
  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((movieData) {
      return Comment(
        id: movieData['_id'],
        titulo: movieData['descricao'],
        imgUrl: movieData['imagem'],
        conteudo: movieData['postagem'],
      );
    }).toList();
  } else {
    throw Exception('Falha ao carregar os comentários');
  }
}

Future<void> postComm(Comment comentario) async {
  final Uri apiUrl = Uri.parse(Url);

  try {
    final response = await http.post(
      apiUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(comentario.toJson()),
    );

    if (response.statusCode == 201) {
      print('Comentário adicionado com sucesso!');
    } else {
      print(
          'Falha ao adicionar o comentário. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Erro durante a solicitação POST: $error');
  }
}

Future<void> attComment(String id, Comment comentario) async {
  final Uri apiUrl = Uri.parse('$Url/update_post/$id');

  try {
    final response = await http.put(
      apiUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(comentario.toJson()),
    );

    if (response.statusCode == 200) {
      print('Comentário atualizado com sucesso!');
    } else {
      print(
          'Falha ao atualizar o comentário. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Erro durante a solicitação PUT: $error');
  }
}

Future<void> deleteComment(String id) async {
  final Uri apiUrl = Uri.parse('$Url/delete_post/$id');

  try {
    final response = await http.delete(apiUrl);

    if (response.statusCode == 200) {
      print('Comentário removido com sucesso!');
    } else {
      print(
          'Falha ao remover o comentário. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Erro durante a solicitação DELETE: $error');
  }
}

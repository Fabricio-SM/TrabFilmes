class Comment {
  final String id;
  final String titulo;
  final String imgUrl;
  final String conteudo;

  Comment(
      {required this.id, required this.titulo, required this.imgUrl, required this.conteudo});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricao': titulo,
      'imagem': imgUrl,
      'postagem': conteudo,
    };
  }
}

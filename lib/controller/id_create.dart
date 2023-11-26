import 'dart:math';

String generateRandomId({int length = 24}) {
  const characters = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final random = Random();
  String randomId = '';

  for (int i = 0; i < length; i++) {
    randomId += characters[random.nextInt(characters.length)];
  }

  return randomId;
}

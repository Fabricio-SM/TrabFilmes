import 'package:flutter/material.dart';

class ImagePathProvider extends ChangeNotifier {
  static late String _imagePath;

  String get imagePath => _imagePath;

  void setImagePath(String imagePath) {
    ImagePathProvider._imagePath = imagePath;
    notifyListeners();
  }

  String getImagePath() {
    print('Caminho da Imagem: $imagePath');
    return imagePath;
  }
}

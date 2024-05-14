import 'package:flutter/material.dart';

class ImagePathProvider extends ChangeNotifier {
  late String _imagePath = '';

  String get imagePath => _imagePath;

  void setImagePath(String imagePath) {
    _imagePath = imagePath;
    notifyListeners();
  }

  String getImagePath() {
    return _imagePath;
  }
}

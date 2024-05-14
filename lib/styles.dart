

import 'package:flutter/material.dart';

class TextStyles {
  TextStyle titulo = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  TextStyle fonte2 = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  TextStyle labelStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  Container imagecontainer = Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
    ),
  );

  InputDecoration inputDecoration = const InputDecoration(
    border: OutlineInputBorder(),
    contentPadding: EdgeInsets.all(12),
  );
}


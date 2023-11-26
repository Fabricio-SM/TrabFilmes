// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TextStyles {
  TextStyle titulo = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  TextStyle fonte2 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  TextStyle labelStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  Container imagecontainer = Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
    ),
  );

  InputDecoration inputDecoration = InputDecoration(
    border: OutlineInputBorder(),
    contentPadding: EdgeInsets.all(12),
  );
}


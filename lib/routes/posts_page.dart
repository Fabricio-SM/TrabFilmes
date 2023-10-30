// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_print, library_private_types_in_public_api, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _PostMenuState();
}

class _PostMenuState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 242, 248),
      body: SingleChildScrollView(
        child: Expanded(child: Container(color: Color.fromARGB(255, 255, 0, 0),),),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'routes.dart';
import 'routes/login_page.dart';

void main() {
  runApp(FilmesApp());
}

class FilmesApp extends StatelessWidget {
  const FilmesApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => "Filmes App",
      initialRoute: RouteGenerator.homePage,
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: FormLogin(),
    );
  }
}

// MultiProvider(
//       providers: [
//         ChangeNotifierProvider<Cache>.value(
//           value: Cache(),
//         ),
//         ChangeNotifierProvider<PetCache>.value(
//           value: PetCache(),
//         ),
//       ],
//       child:
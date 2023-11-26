// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes.dart';
import 'routes/login_page.dart';
import 'widgets/perfil_cache.dart';

void main() async {
  // pede pro flutter utilizar os recursos nativos do android (camera,microfone...)
  // // garante o bind entre o flutter e outra linguagem q esteja sendo usada (por exemplo C#, C++)
  // sempre colocar no caso de ser preciso usar um perfiférico
  WidgetsFlutterBinding.ensureInitialized();

  runApp(FilmesApp());
}

class FilmesApp extends StatelessWidget {
  const FilmesApp();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Cache>.value(
          value: Cache(),
        ),
      ],
      child: MaterialApp(
        onGenerateTitle: (context) => "Filmes App",
        initialRoute: RouteGenerator.homePage,
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.cyan,
        ),
        home: FormLogin(),
      ),
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
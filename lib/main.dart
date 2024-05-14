// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/image_cache.dart';
import 'package:flutter_application_1/services/notification_service.dart';
import 'package:provider/provider.dart';
import 'routes.dart';
import 'routes/login_page.dart';
import 'providers/perfil_cache.dart';

void main() async {
  // sempre colocar no caso de ser preciso usar um perfiférico
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initializeNotificationsChannel();
  runApp(const FilmesApp());
}

class FilmesApp extends StatelessWidget {
  const FilmesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Cache>.value(
          value: Cache(),
        ),
        ChangeNotifierProvider<ImagePathProvider>.value(
          value: ImagePathProvider(),
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
        home: const FormLogin(),
      ),
    );
  }
}

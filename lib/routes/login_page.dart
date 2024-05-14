

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../routes.dart';
import '../providers/perfil_cache.dart';


class FormLogin extends StatefulWidget {
  const FormLogin({super.key});

  @override
  _FormLoginState createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);
    return Consumer<Cache>(builder: (context, cache, _) {
      return Scaffold(
        backgroundColor: Colors.cyanAccent,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              width: mediaQuery.width * 0.9,
              height: mediaQuery.height * 0.7,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.cyan,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 40),
                      child: TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Usuário',
                          filled: true,
                          fillColor: const Color.fromARGB(255, 255, 255, 255),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Digite um nome válido';
                          }

                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 40),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          filled: true,
                          fillColor: const Color.fromARGB(255, 255, 255, 255),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Digite um endereço de email válido';
                          }

                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 40),
                      child: TextFormField(
                        controller: _passwdController,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          filled: true,
                          fillColor: const Color.fromARGB(255, 255, 255, 255),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color:
                                    Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Digite uma senha válida';
                          }

                          return null;
                        },
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        // fixedSize: Size(mediaQuery.width / 1.5, 50),
                        elevation: 90,
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          final nome = _nameController.text;
                          final email = _emailController.text;
                          final senha = _passwdController.text;

                          cache.addItem(nome, email, null, senha);
                          Navigator.of(context)
                              .pushNamed(RouteGenerator.tabsPage);
                        }
                      },
                      child: const Text(
                        'Entrar no app',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

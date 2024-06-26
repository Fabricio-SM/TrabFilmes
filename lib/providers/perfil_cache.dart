import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/user.dart';

class Cache extends ChangeNotifier {
  var _index = -1;

  final List<User> _login = [];

  // Adiciona novos items na lista
  void addItem(String nome, String email, String? dataNasc, String senha) {
    _login.add(User(nome, email, dataNasc, senha));
    notifyListeners();
  }

  // Recupera o index do último elemento selecionado.
  int get index => _index;

  // Atualiza o index
  set index(int value) {
    if ((value >= 0) && (value < _login.length)) {
      _index = value;
    } else {
      _index = -1;
    }
  }

  UnmodifiableListView<User> get listPerfil =>
      UnmodifiableListView<User>(_login);
}

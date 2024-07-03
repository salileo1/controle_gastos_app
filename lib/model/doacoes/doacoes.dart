import 'package:flutter/material.dart';


class Doacoes with ChangeNotifier {
  String id;
  String nome;
  String categoria;
  String quantidade;

  Doacoes({
    required this.id,
    required this.nome,
    required this.categoria,
    required this.quantidade,
  });
}

class DoacoesFormData {
  String id;
  String nome;
  String categoria;
  String quantidade;

  DoacoesFormData({
    this.id = '',
    this.nome = '',
    this.categoria = '',
    this.quantidade = ''
  });
}
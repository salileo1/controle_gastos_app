import 'package:flutter/material.dart';


class Entradas with ChangeNotifier {
  String id;
  String data;
  String entrada;
  String saida;


  Entradas({
    required this.id,
    required this.data,
    required this.entrada,
    required this.saida,
  });
}

class EntradasFormData {
  String id;
  String data;
  String entrada;
  String saida;

  EntradasFormData({
    this.id = '',
    this.data = '',
    this.entrada = '',
    this.saida = '',
  });
}
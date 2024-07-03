import 'package:flutter/material.dart';


class Refeicoes with ChangeNotifier {
  String id;
  String data;
  List<Map<String, String>> locais;

  Refeicoes({
    required this.id,
    required this.data,
    required this.locais,
  });
}

class RefeicoesFormData {
  String id;
  String data;
  List<Map<String, String>> locais;

  RefeicoesFormData({
    this.id = '',
    this.data = '',
    this.locais = const []
  });
}
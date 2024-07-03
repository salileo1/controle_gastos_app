import 'package:controle_gasto/pages/entradas/entradas_list_view.dart';
import 'package:flutter/material.dart';

import '../../components/menu/menu.dart';



class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      drawer: CustomMenu1(),
      body: EntradaListViewPage()
    );
  }
}

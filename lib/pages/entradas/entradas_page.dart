import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../components/entradas/add_entradas.dart';
import '../../components/menu/menu.dart';
import 'entradas_list_view.dart';


class EntradasPage extends StatefulWidget {
  const EntradasPage({super.key});

  @override
  State<EntradasPage> createState() => _EntradasPageState();
}

class _EntradasPageState extends State<EntradasPage> {
  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              Expanded(
                child: EntradaListViewPage(),
              ),
            ],
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return AddEntradasModal();
                },
              );
            },
            child: Icon(Icons.add, color: Color(0xFF7B0000),),
          ),
        ],
      ),
      drawer: CustomMenu1(),
    );
  }
}
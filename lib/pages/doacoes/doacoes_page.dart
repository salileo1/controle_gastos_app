import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../components/doacoes/add_doacoes.dart';
import '../../components/entradas/add_entradas.dart';
import '../../components/menu/menu.dart';
import '../../components/refeicoes/refeicoes_add_modal.dart';
import 'doacoes_list_view.dart';



class DoacoesPage extends StatefulWidget {
  const DoacoesPage({super.key});

  @override
  State<DoacoesPage> createState() => _DoacoesPageState();
}

class _DoacoesPageState extends State<DoacoesPage> {
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
                child: DoacoesListViewPage(),
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
                  return AddDoacoesModal();
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
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../components/entradas/add_entradas.dart';
import '../../components/menu/menu.dart';
import '../../components/refeicoes/refeicoes_add_modal.dart';
import 'refeicoes_list_view.dart';


class RefeicoesPage extends StatefulWidget {
  const RefeicoesPage({super.key});

  @override
  State<RefeicoesPage> createState() => _RefeicoesPageState();
}

class _RefeicoesPageState extends State<RefeicoesPage> {
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
                child: RefeicoesListViewPage(),
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
                  return AddRefeicoesModal();
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
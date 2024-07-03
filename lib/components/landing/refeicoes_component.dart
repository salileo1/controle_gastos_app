import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../model/doacoes/doacoes.dart';
import '../../model/doacoes/doacoes_list.dart';
import '../../model/entradas/entradas_list.dart';
import '../../model/refeicoes/refeicoes.dart';
import '../../model/refeicoes/refeicoes_list.dart';
import '../../pages/refeicoes/refeicoes_info_page.dart';
import '../doacoes/edit_doacoes.dart';

class RefeicoesComponent extends StatelessWidget {
  const RefeicoesComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final produtosList = Provider.of<RefeicoesList>(context);
    List<Refeicoes> _tarefas = [];
    bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Refeições entregues',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 25 : 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: FutureBuilder<List<Refeicoes>>(
              future: produtosList.buscarSetor(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Erro ao carregar os setores'),
                  );
                } else {
                  _tarefas = snapshot.data ?? [];
                  if (_tarefas.isEmpty) {
                    return Center(
                      child: Text('Nenhum setor adicionado'),
                    );
                  } else {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width + 50,
                      child: DataTable(
                        columnSpacing: 15,
                        columns: _buildColumns(isSmallScreen),
                        rows: _tarefas.map((setor) {
                          return DataRow(
                            cells: _buildCells(context, produtosList, setor, isSmallScreen),
                          );
                        }).toList(),
                      ),
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  List<DataColumn> _buildColumns(bool isSmallScreen) {
    List<DataColumn> columns = [
      DataColumn(label: Text('Dia', style: TextStyle(fontSize: 15))),
      DataColumn(label: Text('Janta', style: TextStyle(fontSize: 15))),
      DataColumn(label: Text('Almoço', style: TextStyle(fontSize: 15))),
    ];

    if (!isSmallScreen) {
      columns.addAll([
        DataColumn(label: Text('Café da manhã', style: TextStyle(fontSize: 15))),
        DataColumn(label: Text('Café da tarde', style: TextStyle(fontSize: 15))),
      ]);
    }

    // Add "Infos" column at the end
    columns.add(DataColumn(label: Text('Infos', style: TextStyle(fontSize: 15))));

    return columns;
  }

  List<DataCell> _buildCells(BuildContext context, RefeicoesList produtosList, Refeicoes setor, bool isSmallScreen) {
    List<DataCell> cells = [
      DataCell(Text(setor.data)),
      DataCell(
        FutureBuilder<Map<String, int>>(
          future: produtosList.calcularSomaJantaDocumento(setor.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Erro: ${snapshot.error}');
            } else {
              int somaJanta = snapshot.data!['somaJanta'] ?? 0;
              return Text(somaJanta.toString());
            }
          },
        ),
      ),
      DataCell(
        FutureBuilder<Map<String, int>>(
          future: produtosList.calcularSomaJantaDocumento(setor.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Erro: ${snapshot.error}');
            } else {
              int somaAlmoco = snapshot.data!['somaAlmoco'] ?? 0;
              return Text(somaAlmoco.toString());
            }
          },
        ),
      ),

      
    ];

    if (!isSmallScreen) {
      cells.addAll([
        DataCell(
          FutureBuilder<Map<String, int>>(
            future: produtosList.calcularSomaJantaDocumento(setor.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              } else {
                int somaCafeManha = snapshot.data!['somaCafeManha'] ?? 0;
                return Text(somaCafeManha.toString());
              }
            },
          ),
        ),
        DataCell(
          FutureBuilder<Map<String, int>>(
            future: produtosList.calcularSomaJantaDocumento(setor.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              } else {
                int somaCafeTarde = snapshot.data!['somaCafeTarde'] ?? 0;
                return Text(somaCafeTarde.toString());
              }
            },
          ),
        ),
        
      ]);
    }

    cells.addAll([
        DataCell(
          InkWell(
            child: Icon(Icons.info),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RefeicoesInfoPage(
                    setor: setor,
                  ),
                ),
              );
            },
          ),
        ),
        
      ]);

    return cells;
  }
}

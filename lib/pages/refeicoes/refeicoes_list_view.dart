  import 'package:controle_gasto/model/refeicoes/refeicoes_list.dart';
import 'package:controle_gasto/pages/refeicoes/refeicoes_info_page.dart';
  import 'package:flutter/material.dart';
  import 'package:intl/intl.dart';
  import 'package:provider/provider.dart';
  import '../../model/entradas/entradas.dart';
  import '../../model/entradas/entradas_list.dart';
  import '../../model/refeicoes/refeicoes.dart';

  class RefeicoesListViewPage extends StatefulWidget {
    const RefeicoesListViewPage({Key? key}) : super(key: key);

    @override
    _RefeicoesListViewPageState createState() => _RefeicoesListViewPageState();
  }

  class _RefeicoesListViewPageState extends State<RefeicoesListViewPage> {
    TextEditingController _searchController = TextEditingController();
    List<Refeicoes> _tarefas = [];
    
    @override
    Widget build(BuildContext context) {
      final produtosList = Provider.of<RefeicoesList>(context);
      
      return Padding(
        padding: const EdgeInsets.all(20.0),
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
                        'Refeições',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          
            Expanded(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FutureBuilder<List<Refeicoes>>(
                  future: produtosList.buscarSetor(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(color: Color(0xFF7B0000)),
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
                      return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: DataTable(
                                  columnSpacing: 20,
                                  columns: [
                                    DataColumn(label: Text('Dia')),
                                    DataColumn(label: Text('Janta')),
                                    DataColumn(label: Text('Almoço')),
                                    DataColumn(label: Text('Café da manha')),
                                    DataColumn(label: Text('Café da tarde')),
                                    DataColumn(label: Text('Infos')),
                                  ],
                                  rows: _tarefas.map((setor) {
                                    return DataRow(
                                      cells: [
                                        DataCell(Text(setor.data)),
                                        DataCell(
                                          FutureBuilder<Map<String, int>>(
                                            future: produtosList.calcularSomaJantaDocumento(setor.id),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                return CircularProgressIndicator(color: Color(0xFF7B0000));
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
                                                return CircularProgressIndicator(color: Color(0xFF7B0000));
                                              } else if (snapshot.hasError) {
                                                return Text('Erro: ${snapshot.error}');
                                              } else {
                                                int somaAlmoco = snapshot.data!['somaAlmoco'] ?? 0;
                                                return Text(somaAlmoco.toString());
                                              }
                                            },
                                          ),
                                        ),
                                        DataCell(
                                          FutureBuilder<Map<String, int>>(
                                            future: produtosList.calcularSomaJantaDocumento(setor.id),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                return CircularProgressIndicator(color: Color(0xFF7B0000));
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
                                                return CircularProgressIndicator(color: Color(0xFF7B0000));
                                              } else if (snapshot.hasError) {
                                                return Text('Erro: ${snapshot.error}');
                                              } else {
                                                int somaCafeTarde = snapshot.data!['somaCafeTarde'] ?? 0;
                                                return Text(somaCafeTarde.toString());
                                              }
                                            },
                                          ),
                                        ),
                                        DataCell(
                                         InkWell(
                                            child: Icon(Icons.info),
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      RefeicoesInfoPage(
                                                    setor: setor,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          );
                      }
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

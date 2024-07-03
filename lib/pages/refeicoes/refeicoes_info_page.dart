import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controle_gasto/model/refeicoes/refeicoes.dart';
import 'package:provider/provider.dart';
import '../../model/refeicoes/refeicoes_list.dart';

class RefeicoesInfoPage extends StatefulWidget {
  final Refeicoes setor;

  const RefeicoesInfoPage({required this.setor, Key? key}) : super(key: key);

  @override
  _RefeicoesInfoPageState createState() => _RefeicoesInfoPageState();
}

class _RefeicoesInfoPageState extends State<RefeicoesInfoPage> {
  late Future<List<Refeicoes>> _futureRefeicoes;

  @override
  void initState() {
    super.initState();
    _futureRefeicoes = buscarSetor(widget.setor.id);
  }

  Future<List<Refeicoes>> buscarSetor(String id) async {
  CollectionReference<Map<String, dynamic>> processosRef =
      FirebaseFirestore.instance.collection('refeicoes');

  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await processosRef.where('id', isEqualTo: id).get();
    List<Refeicoes> processos = [];

    for (final doc in querySnapshot.docs) {
      final resultado = doc.data();

      print('Dados do documento: $resultado');

      final List<dynamic> locaisData = resultado['refeicoes'] ?? [];
      final List<Map<String, String>> locais = List<Map<String, String>>.from(locaisData.map((item) => Map<String, String>.from(item)));

      final setor = Refeicoes(
        id: resultado['id'].toString() ?? '',
        data: resultado['data'] ?? '',
        locais: locais,
      );

      processos.add(setor);
    }

    return processos;
  } catch (e) {
    print('Erro ao buscar os setores: $e');
    return []; // Retorna uma lista vazia em caso de erro
  }
}

  @override
  Widget build(BuildContext context) {
    List<Refeicoes> _tarefas = [];
    final produtosList = Provider.of<RefeicoesList>(context);
    var _somaFuture = produtosList.calcularSomaJantaDocumento(widget.setor.id);
    bool isSmallScreen = MediaQuery.of(context).size.width < 900;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Informações do dia ${widget.setor.data}',
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            child: Card(
              elevation: 7,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Informações do dia',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Data: ',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${widget.setor.data}',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                     Text(
                      'Total: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    FutureBuilder<Map<String, int>>(
                    future: _somaFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator(color: Color(0xFF7B0000)));
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Erro: ${snapshot.error}'));
                      } else {
                        final soma = snapshot.data!;
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: DataTable(
                            columns: [
                              DataColumn(label: Text('Refeição')),
                              DataColumn(label: Text('Quantidade')),
                            ],
                            rows: [
                              DataRow(cells: [
                                DataCell(Text('Janta')),
                                DataCell(Text(soma['somaJanta'].toString())),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('Almoço')),
                                DataCell(Text(soma['somaAlmoco'].toString())),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('Café da manhã')),
                                DataCell(Text(soma['somaCafeManha'].toString())),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('Café da Tarde')),
                                DataCell(Text(soma['somaCafeTarde'].toString())),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('Total', style: TextStyle(fontWeight: FontWeight.bold),)),
                                DataCell(Text(soma['somaTotal'].toString(), style: TextStyle(fontWeight: FontWeight.bold),)),
                              ]),
                            ],
                          ),

                        );}
                        }),
                    Text(
                      'Locais: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    FutureBuilder<List<Refeicoes>>(
                      future: _futureRefeicoes,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child:CircularProgressIndicator(color: Color(0xFF7B0000)));
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Erro: ${snapshot.error}'));
                        } else {
                          final refeicoes = snapshot.data ?? [];
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: isSmallScreen ? 
                            DataTable(
                              columnSpacing: 1,
                              columns: [
                                DataColumn(label: Text('Local', style: TextStyle(fontSize: 12,))),
                                DataColumn(label: Text('Janta', style: TextStyle(fontSize: 12,))),
                                DataColumn(label: Text('Almoço', style: TextStyle(fontSize: 12,))),
                                DataColumn(label: Text('Café da manhã', style: TextStyle(fontSize: 12,))),
                                DataColumn(label: Text('Café da tarde', style: TextStyle(fontSize: 12,))),
                              ],
                              rows: refeicoes.expand((refeicao) {
                                return refeicao.locais.map((local) {
                                  return DataRow(cells: [
                                    DataCell(Text(local['nome'] ?? '0', style: TextStyle(fontSize: 12,))),
                                    DataCell(Text(local['janta'] ?? '0', style: TextStyle(fontSize: 12,))),
                                    DataCell(Text(local['almoco'] ?? '0', style: TextStyle(fontSize: 12,))),
                                    DataCell(Text(local['cafe_manha'] ?? '0', style: TextStyle(fontSize: 12,))),
                                    DataCell(Text(local['cafe_tarde'] ?? '0', style: TextStyle(fontSize: 12,))),
                                  ]);
                                }).toList();
                              }).toList(),
                            )

                            :DataTable(
                              columns: [
                                DataColumn(label: Text('Local', )),
                                DataColumn(label: Text('Janta')),
                                DataColumn(label: Text('Almoço')),
                                DataColumn(label: Text('Café da manhã')),
                                DataColumn(label: Text('Café da tarde')),
                              ],
                              rows: refeicoes.expand((refeicao) {
                              return refeicao.locais.map((local) {
                                return DataRow(
                                  cells: [
                                    DataCell(Text(local['nome'] ?? '0')),
                                    DataCell(Text(local['janta'] ?? '0')),
                                    DataCell(Text(local['almoco'] ?? '0')),
                                    DataCell(Text(local['cafe_manha'] ?? '0')),
                                    DataCell(Text(local['cafe_tarde'] ?? '0')),
                                  ],
                                );
                              }).toList();
                            }).toList(),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

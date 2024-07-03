import 'package:controle_gasto/components/doacoes/edit_doacoes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:controle_gasto/model/doacoes/doacoes_list.dart';

import '../../model/doacoes/doacoes.dart';

class DoacoesListViewPage extends StatefulWidget {
  const DoacoesListViewPage({Key? key}) : super(key: key);

  @override
  _DoacoesListViewPageState createState() => _DoacoesListViewPageState();
}

class _DoacoesListViewPageState extends State<DoacoesListViewPage> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final doacoesList = Provider.of<DoacoesList>(context);

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
                      'Doações',
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
            child: FutureBuilder<List<Doacoes>>(
              future: doacoesList.buscarSetor(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: Color(0xFF7B0000)),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Erro ao carregar as doações'),
                  );
                } else {
                  List<Doacoes>? doacoes = snapshot.data;
                  if (doacoes == null || doacoes.isEmpty) {
                    return Center(
                      child: Text('Nenhuma doação encontrada'),
                    );
                  } else {
                    // Agrupar doações por categoria
                    Map<String, List<Doacoes>> groupedDoacoes = {};
                    for (var doacao in doacoes) {
                      if (!groupedDoacoes.containsKey(doacao.categoria)) {
                        groupedDoacoes[doacao.categoria] = [];
                      }
                      groupedDoacoes[doacao.categoria]!.add(doacao);
                    }

                    // Calcular as somas das quantidades por categoria
                    Map<String, int> somaQuantidadesPorCategoria = {};
                    for (var categoria in groupedDoacoes.keys) {
                      int somaQuantidade = groupedDoacoes[categoria]!
                          .map((doacao) => int.tryParse(doacao.quantidade) ?? 0)
                          .reduce((value, element) => value + element);
                      somaQuantidadesPorCategoria[categoria] = somaQuantidade;
                    }

                    return ListView.builder(
                      itemCount: groupedDoacoes.length,
                      itemBuilder: (context, index) {
                        String categoria = groupedDoacoes.keys.elementAt(index);
                        List<Doacoes>? doacoesCategoria = groupedDoacoes[categoria];
                        int somaQuantidade = somaQuantidadesPorCategoria[categoria] ?? 0;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    categoria,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Total: $somaQuantidade',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: doacoesCategoria!.length,
                              itemBuilder: (context, index) {
                                final doacao = doacoesCategoria[index];
                                return ListTile(
                                  title: Text('Nome: ${doacao.nome}'),
                                  subtitle: Text('Quantidade: ${doacao.quantidade}'),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit, color: Colors.green),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return EditDoacoesPopup(
                                                fornecedor: doacao,
                                              );});
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete, color: Colors.red),
                                        onPressed: () {
                                          // Adicione aqui a lógica para remover a doação
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('Remover Doação'),
                                                content: Text('Tem certeza que deseja remover esta doação?'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      doacoesList.removerSetor(doacao.id);
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Text('Sim'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Text('Cancelar'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),

                            Divider(), // Adicionar um divisor entre as categorias
                          ],
                        );
                      },
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
}

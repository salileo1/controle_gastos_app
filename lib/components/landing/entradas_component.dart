import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../model/doacoes/doacoes.dart';
import '../../model/doacoes/doacoes_list.dart';
import '../../model/entradas/entradas_list.dart';

class EntradasComponent extends StatelessWidget {
  const EntradasComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final produtosList = Provider.of<EntradasList>(context);
    final formatter = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    final saldo = produtosList.somaDasEntradas[0] - produtosList.somaDasSaidas[0];
    final doacoesList = Provider.of<DoacoesList>(context);

    bool isSmallScreen = MediaQuery.of(context).size.width < 900;

    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: isSmallScreen
          ? Column(
              children: [
                _buildGastosSection(context, produtosList, formatter, saldo as double),
                SizedBox(height: 20),
                _buildDoacoesSection(context, doacoesList),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildGastosSection(context, produtosList, formatter, saldo as double)),
                SizedBox(width: 40),
                Expanded(child: _buildDoacoesSection(context, doacoesList)),
              ],
            ),
    );
  }

  Widget _buildGastosSection(BuildContext context, EntradasList produtosList, NumberFormat formatter, double saldo) {
     bool isSmallScreen = MediaQuery.of(context).size.width < 600;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                    'Controle de gastos',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 25 : 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        _buildCard(
          title: 'Entradas:',
          value: formatter.format(produtosList.somaDasEntradas[0]),
          backgroundColor: Colors.green[200],
        ),
        SizedBox(height: 20),
        _buildCard(
          title: 'Saídas:',
          value: formatter.format(produtosList.somaDasSaidas[0]),
          backgroundColor: Colors.red[200],
        ),
        SizedBox(height: 20),
        _buildCard(
          title: 'Saldo em conta:',
          value: formatter.format(saldo),
          backgroundColor: Colors.yellow[200],
        ),
      ],
    );
  }

  Widget _buildDoacoesSection(BuildContext context, DoacoesList doacoesList) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 600;
    return FutureBuilder<List<Doacoes>>(
      future: doacoesList.buscarSetor(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
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
            Map<String, List<Doacoes>> groupedDoacoes = {};
            for (var doacao in doacoes) {
              if (!groupedDoacoes.containsKey(doacao.categoria)) {
                groupedDoacoes[doacao.categoria] = [];
              }
              groupedDoacoes[doacao.categoria]!.add(doacao);
            }

            Map<String, int> somaQuantidadesPorCategoria = {};
            for (var categoria in groupedDoacoes.keys) {
              int somaQuantidade = groupedDoacoes[categoria]!
                  .map((doacao) => int.tryParse(doacao.quantidade) ?? 0)
                  .reduce((value, element) => value + element);
              somaQuantidadesPorCategoria[categoria] = somaQuantidade;
            }

            return Column(
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
                            'Doações em estoque',
                            style: TextStyle(
                              fontSize: isSmallScreen ? 25 : 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
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
                                  fontSize: isSmallScreen ? 15 : 20,
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
                            );
                          },
                        ),
                        Divider(),
                      ],
                    );
                  },
                ),
              ],
            );
          }
        }
      },
    );
  }

  Widget _buildCard({required String title, required String value, Color? backgroundColor}) {
    return Container(
      width: double.infinity,
      child: Card(
        color: backgroundColor ?? Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:controle_gasto/model/refeicoes/refeicoes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class RefeicoesList with ChangeNotifier {
  late final List<Refeicoes> _items;

  RefeicoesList() {
    _items = [];
    _carregarSetores();
  }
  List<Refeicoes> get items => [..._items];

  Future<void> _carregarSetores() async {
    final List<Refeicoes> clientes = await buscarSetor();
    _items.addAll(clientes);
    notifyListeners();
  }

  Future<List<Refeicoes>> buscarSetor() async {
    CollectionReference<Map<String, dynamic>> processosRef =
        FirebaseFirestore.instance.collection('refeicoes');

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await processosRef.get();
      List<Refeicoes> processos = [];

      for (final doc in querySnapshot.docs) {
        final resultado = doc.data();

        print('Dados do documento: $resultado');

        final setor = Refeicoes(
          id: resultado['id'].toString() ?? '',
          data: resultado['data'] ?? '',
          locais: resultado['locais'] ?? [],
        );

        processos.add(setor);
      }

      return processos;
    } catch (e) {
      print('Erro ao buscar os setores: $e');
      return []; // Retorna uma lista vazia em caso de erro
    }
  }

  Future<List<Refeicoes>> cadastrarTarefa(
    Refeicoes entradas,
  ) async {
    CollectionReference<Map<String, dynamic>> processosRef =
        FirebaseFirestore.instance.collection('refeicoes');

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await processosRef.get();

      
      final agendamento = Refeicoes(
        id: entradas.id,
        data: entradas.data,
        locais: entradas.locais
      );

      await processosRef.doc(entradas.id).set({
        'id': agendamento.id,
        'data': agendamento.data,
        'refeicoes': agendamento.locais
      });

      List<Refeicoes> processos = [agendamento];

      _items.add(agendamento);
      notifyListeners();
      return processos;
    } catch (e) {
      print('Erro ao buscar os imóveis: $e');
      return [];
    }
  }

  Future<void> removerSetor(String id) async {
    try {
      // Remover o procedimento da coleção no Firestore
      await FirebaseFirestore.instance.collection('refeicoes').doc(id).delete();

      print('Procedimento removido do Firestore com sucesso');

      // Remover o procedimento da lista local
      _items.removeWhere((procedimento) => procedimento.id == id);

      print('Procedimento removido da lista local com sucesso');

      // Notificar os ouvintes sobre a mudança na lista
      notifyListeners();
    } catch (e) {
      print("Erro ao remover procedimento: $e");
    }
  }

  Future<Map<String, int>> calcularSomaJantaDocumento(String documentoId) async {
  int somaJanta = 0;
  int somaAlmoco = 0;
  int somaCafeTarde = 0;
  int somaCafeManha = 0;
  int somaTotal = 0;
  try {
    // Obter o documento específico do Firestore
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('refeicoes').doc(documentoId).get();
    if (snapshot.exists) {
      // Se o documento existe, obter seus dados
      Map<String, dynamic> data = snapshot.data()!;
      // Verificar se o campo 'refeicoes' existe e é uma lista
      if (data.containsKey('refeicoes') && data['refeicoes'] is List) {
        // Percorrer a lista de refeições
        List<dynamic> refeicoes = data['refeicoes'];
        for (var refeicao in refeicoes) {
          // Verificar se o campo 'janta' existe e é um número
          if (refeicao is Map && refeicao.containsKey('janta')) {
            String janta = refeicao['janta'];
            int jantaInt = int.parse(janta);
            somaJanta += jantaInt;

            String almoco = refeicao['almoco'];
            int almocoInt = int.parse(almoco);
            somaAlmoco += almocoInt;

            String cafeTarde = refeicao['cafe_tarde'];
            int cafeT = int.parse(cafeTarde);
            somaCafeTarde += cafeT;

            String cafeManha = refeicao['cafe_manha'];
            int cafeM = int.parse(cafeManha);
            somaCafeManha += cafeM;

            somaTotal = somaCafeManha + somaCafeTarde + somaAlmoco + somaJanta;
          }
        }
      }
    }
  } catch (e) {
    print('Erro ao calcular a soma de janta do documento $documentoId: $e');
  }
  
  return {
    'somaJanta': somaJanta,
    'somaAlmoco': somaAlmoco,
    'somaCafeTarde': somaCafeTarde,
    'somaCafeManha': somaCafeManha,
    'somaTotal': somaTotal
  };
}


}
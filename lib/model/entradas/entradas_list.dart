import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


import 'entradas.dart';

class EntradasList with ChangeNotifier {
  late final List<Entradas> _items;

  EntradasList() {
    _items = [];
    _carregarSetores();
  }
  List<Entradas> get items => [..._items];

  Future<void> _carregarSetores() async {
    final List<Entradas> clientes = await buscarSetor();
    _items.addAll(clientes);
    notifyListeners();
  }

  Future<List<Entradas>> buscarSetor() async {
    CollectionReference<Map<String, dynamic>> processosRef =
        FirebaseFirestore.instance.collection('entradas');

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await processosRef.get();
      List<Entradas> processos = [];

      for (final doc in querySnapshot.docs) {
        final resultado = doc.data();

        final setor = Entradas(
          id: resultado['id'].toString() ?? '',
          data: resultado['data'] ?? '',
          entrada: resultado['entrada'] ?? '',
          saida: resultado['saida'] ?? '',
        );

        processos.add(setor);
      }

      return processos;
    } catch (e) {
      print('Erro ao buscar os setores: $e');
      return []; // Retorna uma lista vazia em caso de erro
    }
  }

  Future<List<Entradas>> cadastrarTarefa(
    Entradas entradas,
  ) async {
    CollectionReference<Map<String, dynamic>> processosRef =
        FirebaseFirestore.instance.collection('entradas');

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await processosRef.get();

      
      final agendamento = Entradas(
        id: entradas.id,
        data: entradas.data,
        entrada: entradas.entrada,
        saida: entradas.saida,
      );

      await processosRef.doc(entradas.id).set({
        'id': agendamento.id,
        'data': agendamento.data,
        'saida': agendamento.saida,
        'entrada': agendamento.entrada,
      });

      List<Entradas> processos = [agendamento];

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
      await FirebaseFirestore.instance.collection('entradas').doc(id).delete();

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

   List<int> get somaDasEntradas {
    // Crie uma lista vazia para armazenar as somas das entradas
    List<int> somaList = [];

    // Itere sobre todos os itens e converta cada entrada em um número inteiro
    for (var entrada in _items) {
      // Converta a entrada para inteiro e adicione à lista de somas
      somaList.add(int.tryParse(entrada.entrada) ?? 0);
    }

    // Calcule a soma total das entradas
    int total = somaList.reduce((value, element) => value + element);

    return [total];
  }

  List<int> get somaDasSaidas {
    // Crie uma lista vazia para armazenar as somas das entradas
    List<int> somaList = [];

    // Itere sobre todos os itens e converta cada entrada em um número inteiro
    for (var saida in _items) {
      // Converta a entrada para inteiro e adicione à lista de somas
      somaList.add(int.tryParse(saida.saida) ?? 0);
    }

    // Calcule a soma total das entradas
    int total = somaList.reduce((value, element) => value + element);

    return [total];
  }


  
}
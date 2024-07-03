import 'dart:async';
import 'package:controle_gasto/model/doacoes/doacoes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DoacoesList with ChangeNotifier {
  late final List<Doacoes> _items;

  DoacoesList() {
    _items = [];
    _carregarSetores();
  }
  List<Doacoes> get items => [..._items];

  Future<void> _carregarSetores() async {
    final List<Doacoes> clientes = await buscarSetor();
    _items.addAll(clientes);
    notifyListeners();
  }

  Future<List<Doacoes>> buscarSetor() async {
    CollectionReference<Map<String, dynamic>> processosRef =
        FirebaseFirestore.instance.collection('doacoes');

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await processosRef.get();
      List<Doacoes> processos = [];

      for (final doc in querySnapshot.docs) {
        final resultado = doc.data();

        final setor = Doacoes(
          id: resultado['id'].toString() ?? '',
          nome: resultado['nome'] ?? '',
          categoria: resultado['categoria'] ?? '',
          quantidade: resultado['quantidade'] ?? '',
        );

        processos.add(setor);
      }

      return processos;
    } catch (e) {
      print('Erro ao buscar os setores: $e');
      return []; // Retorna uma lista vazia em caso de erro
    }
  }

  Future<List<Doacoes>> cadastrarTarefa(Doacoes entradas) async {
    CollectionReference<Map<String, dynamic>> processosRef =
        FirebaseFirestore.instance.collection('doacoes');

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await processosRef.get();

      int proximoId = 1;

      if (querySnapshot.docs.isNotEmpty) {
        final ultimoId =
            querySnapshot.docs.map((doc) => int.parse(doc['id'])).reduce((a, b) => a > b ? a : b);
        proximoId = ultimoId + 1;
      }

      final agendamento = Doacoes(
        id: proximoId.toString(),
        nome: entradas.nome,
        categoria: entradas.categoria,
        quantidade: entradas.quantidade,
      );

      await processosRef.doc(agendamento.id).set({
        'id': agendamento.id,
        'nome': agendamento.nome,
        'categoria': agendamento.categoria,
        'quantidade': agendamento.quantidade
      });

      List<Doacoes> processos = [agendamento];

      _items.add(agendamento);
      notifyListeners();
      return processos;
    } catch (e) {
      print('Erro ao cadastrar doação: $e');
      return [];
    }
  }

  Future<void> removerSetor(String id) async {
    try {
      // Remover a doação da coleção no Firestore
      await FirebaseFirestore.instance.collection('doacoes').doc(id).delete();

      // Remover a doação da lista local
      _items.removeWhere((doacao) => doacao.id == id);

      // Notificar os ouvintes sobre a mudança na lista
      notifyListeners();
    } catch (e) {
      print("Erro ao remover doação: $e");
    }
  }

  void atualizarServico(Doacoes formadata) async {
    try {
      // Acessar o documento correspondente no Firebase Firestore
      DocumentReference servicoRef =
          FirebaseFirestore.instance.collection('doacoes').doc(formadata.id);

      // Atualizar os dados do documento
      await servicoRef.update({
        'nome': formadata.nome,
        'quantidade': formadata.quantidade,
        'categoria': formadata.categoria,
      });

      // Atualizar os dados na lista local
      int index = _items.indexWhere((servico) => servico.id == formadata.id);
      if (index != -1) {
        _items[index].nome = formadata.nome;
        _items[index].quantidade = formadata.quantidade;
        _items[index].categoria = formadata.categoria;
        notifyListeners();
      }
    } catch (e) {
      print("Erro ao atualizar serviço: $e");
    }
  }
}

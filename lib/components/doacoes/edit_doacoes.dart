import 'dart:convert';

import 'package:controle_gasto/model/doacoes/doacoes.dart';
import 'package:controle_gasto/model/doacoes/doacoes_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'package:provider/provider.dart';


class EditDoacoesPopup extends StatefulWidget {
  final Doacoes fornecedor;


  EditDoacoesPopup({required this.fornecedor});

  @override
  _EditDoacoesPopupState createState() => _EditDoacoesPopupState();
}

class _EditDoacoesPopupState extends State<EditDoacoesPopup> {
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _categoriaController = TextEditingController();
  TextEditingController _qtdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nomeController.text = widget.fornecedor.nome;
    _categoriaController.text = widget.fornecedor.categoria;
    _qtdController.text = widget.fornecedor.quantidade;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Editar Fornecedor'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nomeController,
              decoration: InputDecoration(
                labelText: 'Nome da doação',
                labelStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                filled: true,
                fillColor: Colors.black12,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _categoriaController,
              decoration: InputDecoration(
                labelText: 'Categoria',
                labelStyle: TextStyle(
                  color: Color(0xFF6DB6B2),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                filled: true,
                fillColor: Colors.black12,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, preencha o campo.';
                }
                return null;
              },
              onChanged: (value) {
                // Atualiza o valor do campo de texto com o novo texto em maiúsculas
                widget.fornecedor.categoria = value;
              },
              onSaved: (value) {
                // Garante que o valor salvo seja em maiúsculas
                widget.fornecedor.categoria = value!.toUpperCase();
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _qtdController,
              decoration: InputDecoration(
                labelText: 'Quantidade',
                labelStyle: TextStyle(
                  color: Color(0xFF6DB6B2),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                filled: true,
                fillColor: Colors.black12,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, preencha o campo.';
                }
                return null;
              },
              onChanged: (value) {
                // Atualiza o valor do campo de texto com o novo texto em maiúsculas
                widget.fornecedor.quantidade = value;
              },
              onSaved: (value) {
                // Garante que o valor salvo seja em maiúsculas
                widget.fornecedor.quantidade = value!.toUpperCase();
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancelar'),
        ),
        ElevatedButton(
  onPressed: () async {
    try {
      // Atualizar os valores do fornecedor com os valores dos controllers
      widget.fornecedor.nome = _nomeController.text;
      widget.fornecedor.quantidade = _qtdController.text;
      widget.fornecedor.categoria = _categoriaController.text;

      // Atualizar o serviço no Firestore e na lista local
      Provider.of<DoacoesList>(context, listen: false)
          .atualizarServico(widget.fornecedor);

      // Exibir uma mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Doação atualizada com sucesso.'),
          backgroundColor: Colors.green,
        ),
      );

      // Fechar a modal de edição
      Navigator.pop(context);
    } catch (e) {
      print('Erro ao atualizar doação: $e');
      // Exibir uma mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao atualizar doação. Tente novamente.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  },
  child: Text('Salvar'),
),

      ],
    );
  }
}
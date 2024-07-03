import 'package:controle_gasto/model/doacoes/doacoes.dart';
import 'package:controle_gasto/model/doacoes/doacoes_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import '../../model/entradas/entradas.dart';
import '../../model/entradas/entradas_list.dart';



typedef OnSetorAdicionada = void Function(Doacoes pessoa);

class AddDoacoesModal extends StatefulWidget {
  final OnSetorAdicionada? onPessoaAdded;
  final int? isEdit;


  const AddDoacoesModal(
      {this.onPessoaAdded,
      this.isEdit,
      });

  @override
  _AdPessoaaModalState createState() => _AdPessoaaModalState();
}

class _AdPessoaaModalState extends State<AddDoacoesModal> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  final Doacoes _formData = Doacoes(
    id: '',
    nome: '',
    categoria: '',
    quantidade: '',
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro '),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nome',
                  labelStyle: TextStyle(
                    color: Color(0xFF7B0000),
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
                  _formData.nome = value;
                },
                onSaved: (value) {
                  // Garante que o valor salvo seja em maiúsculas
                  _formData.nome = value!.toUpperCase();
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Categoria',
                  labelStyle: TextStyle(
                    color: Color(0xFF7B0000),
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
                  _formData.categoria = value;
                },
                onSaved: (value) {
                  // Garante que o valor salvo seja em maiúsculas
                  _formData.categoria = value!.toUpperCase();
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Quantidade',
                  labelStyle: TextStyle(
                    color: Color(0xFF7B0000),
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
                  _formData.quantidade = value;
                },
                onSaved: (value) {
                  // Garante que o valor salvo seja em maiúsculas
                  _formData.quantidade = value!.toUpperCase();
                },
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    // Criar uma instância de Pessoa com as informações de _formData
                    Doacoes novoSetor = Doacoes(
                      id: _formData.id,
                      nome: _formData.nome,
                      categoria: _formData.categoria,
                      quantidade: _formData.quantidade,
                    );

                    Provider.of<DoacoesList>(context, listen: false)
                        .cadastrarTarefa(novoSetor);

                    Navigator.pop(context);
                  }
                },
                child: Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
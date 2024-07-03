import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import '../../model/entradas/entradas.dart';
import '../../model/entradas/entradas_list.dart';



typedef OnSetorAdicionada = void Function(Entradas pessoa);

class AddEntradasModal extends StatefulWidget {
  final OnSetorAdicionada? onPessoaAdded;
  final int? isEdit;


  const AddEntradasModal(
      {this.onPessoaAdded,
      this.isEdit,
      });

  @override
  _AdPessoaaModalState createState() => _AdPessoaaModalState();
}

class _AdPessoaaModalState extends State<AddEntradasModal> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  final Entradas _formData = Entradas(
    id: '',
    data: '',
    entrada: '',
    saida: '',
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
                  labelText: 'Dia',
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
                onTap: () async {
                   DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          primaryColor: Color(0xFF7B0000),
                          accentColor: Color(0xFF7B0000),
                          colorScheme: ColorScheme.light(primary: Color(0xFF7B0000),), // Selection color
                          buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary), // Button text color
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (selectedDate != null) {
                    setState(() {
                      _formData.data = DateFormat('dd/MM/yyyy').format(selectedDate);
                      _formData.id = _formData.data.replaceAll('/', '-');
                    });
                  }
                },
                readOnly: true,
                controller: TextEditingController(
                  text: _formData.data,
                ),
                onSaved: (value) {
                  _formData.data = value!;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Entrada',
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
                  _formData.entrada = value;
                },
                onSaved: (value) {
                  // Garante que o valor salvo seja em maiúsculas
                  _formData.entrada = value!.toUpperCase();
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Saida',
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
                  _formData.saida = value;
                },
                onSaved: (value) {
                  // Garante que o valor salvo seja em maiúsculas
                  _formData.saida = value!.toUpperCase();
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
                    Entradas novoSetor = Entradas(
                      id: _formData.id,
                      data: _formData.data,
                      entrada: _formData.entrada,
                      saida: _formData.saida,
                    );

                    Provider.of<EntradasList>(context, listen: false)
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
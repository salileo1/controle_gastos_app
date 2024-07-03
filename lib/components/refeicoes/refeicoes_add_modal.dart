import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../model/refeicoes/refeicoes.dart';
import '../../model/refeicoes/refeicoes_list.dart';

typedef OnSetorAdicionada = void Function(Refeicoes pessoa);

class AddRefeicoesModal extends StatefulWidget {
  final OnSetorAdicionada? onPessoaAdded;
  final int? isEdit;

  const AddRefeicoesModal({this.onPessoaAdded, this.isEdit});

  @override
  _AdPessoaaModalState createState() => _AdPessoaaModalState();
}

class _AdPessoaaModalState extends State<AddRefeicoesModal> {
  final _formKey = GlobalKey<FormState>();
  List<Map<String, String>> _locais = [];

  final Refeicoes _formData = Refeicoes(
    id: '',
    data: '',
    locais: [],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
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
                  labelText: 'Selecione a data',
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
                      _formData.data =
                          DateFormat('dd/MM/yyyy').format(selectedDate);
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
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    Refeicoes novoSetor = Refeicoes(
                      id: _formData.id,
                      data: _formData.data,
                      locais: _locais,
                    );

                    Provider.of<RefeicoesList>(context, listen: false)
                        .cadastrarTarefa(novoSetor);

                    Navigator.pop(context);
                  }
                },
                child: Text('Cadastrar', style: TextStyle(color: Color(0xFF7B0000)),),
              ),
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _locais.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Local ${index + 1}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                       TextFormField(
                        key: const ValueKey('Nome'),
                          onChanged: (value) {
                            _locais[index]['nome'] = value;
                          },
                        obscureText: true,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Nome',
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 15,
                          ),
                          filled: true,
                          fillColor: Colors.black12,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        key: const ValueKey('Jantas'),
                         onChanged: (value) {
                          _locais[index]['janta'] = value;
                        },
                        obscureText: true,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Jantas',
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 15,
                          ),
                          filled: true,
                          fillColor: Colors.black12,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        key: const ValueKey('Almoços'),
                         onChanged: (value) {
                          _locais[index]['almoco'] = value;
                        },
                        obscureText: true,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Almoços',
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 15,
                          ),
                          filled: true,
                          fillColor: Colors.black12,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        key: const ValueKey('Café da manhã'),
                         onChanged: (value) {
                          _locais[index]['cafe_manha'] = value;
                        },
                        obscureText: true,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Café da manhã',
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 15,
                          ),
                          filled: true,
                          fillColor: Colors.black12,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),  
                      SizedBox(height: 20),
                      TextFormField(
                        key: const ValueKey('Café da tarde'),
                         onChanged: (value) {
                          _locais[index]['cafe_tarde'] = value;
                        },
                        obscureText: true,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Café da tarde',
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 15,
                          ),
                          filled: true,
                          fillColor: Colors.black12,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ), 
                    ],
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  _addLocal();
                },
                child: Text('Adicionar Local', style: TextStyle(color: Color(0xFF7B0000)),),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addLocal() {
    setState(() {
      _locais.add({
        'nome': '',
        'janta': '',
        'almoco': '',
        'cafe_manha': '',
        'cafe_tarde': '',
      });
    });
  }
}

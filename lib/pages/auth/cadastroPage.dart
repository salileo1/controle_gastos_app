import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'checkpage.dart';


class cadastroPage extends StatefulWidget {
  const cadastroPage({super.key});

  @override
  State<cadastroPage> createState() => _cadastroPageState();
}

class _cadastroPageState extends State<cadastroPage> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar cadastro"),
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          TextFormField(
            controller: _nomeController,
            decoration: InputDecoration(
              label: Text("Nome completo")
            ),
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              label: Text("Email")
            ),
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              label: Text("Senha")
            ),
          ), 
          ElevatedButton(
            onPressed: (){
              cadastrar();
          }, 
          child: Text("Cadastrar"))
        ],
      ),
    );
  }

  cadastrar() async{
    try{
      UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(
          email: _emailController.text, 
          password: _passwordController.text);
      if(userCredential != null){
        userCredential.user!.updateDisplayName(_nomeController.text);
        Navigator.pushAndRemoveUntil(
          context, 
          MaterialPageRoute(
            builder: (context) => checkPage()
            ),
            (route) => false);
      }

    }on FirebaseAuthException catch(e){
      if(e.code == 'weak-password'){
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Crie uma senha mais forte"),
            backgroundColor: Colors.redAccent,
            ),
          );
      }else if(e.code == 'email-already-in-use'){
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Email já cadastrado"),
            backgroundColor: Colors.redAccent,
            ),
          );
      }
    }
  }
}

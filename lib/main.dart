import 'package:controle_gasto/model/doacoes/doacoes_list.dart';
import 'package:controle_gasto/model/refeicoes/refeicoes_list.dart';
import 'package:controle_gasto/pages/auth/checkpage.dart';
import 'package:controle_gasto/pages/landing.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:ui';

import 'model/entradas/entradas_list.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EntradasList()),
        ChangeNotifierProvider(create: (_) => RefeicoesList()),
        ChangeNotifierProvider(create: (_) => DoacoesList()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ajude Pelotas 2024',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        // Verifica se há um usuário logado
        future: FirebaseAuth.instance.authStateChanges().first,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Aguarde a verificação do estado de autenticação
            return CircularProgressIndicator();
          } else {
            // Se houver um usuário logado, vá para a checkPage, caso contrário, vá para a página de login
            if (snapshot.hasData) {
              return const checkPage();
            } else {
              return LandingPage(); 
            }
          }
        },
      ),
    );
  }
}


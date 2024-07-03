import 'package:controle_gasto/pages/auth/checkpage.dart';
import 'package:controle_gasto/pages/auth/homepage.dart';
import 'package:controle_gasto/pages/doacoes/doacoes_page.dart';
import 'package:controle_gasto/pages/landing.dart';
import 'package:controle_gasto/pages/refeicoes/refeicoes_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../pages/entradas/entradas_page.dart';

class CustomMenu1 extends StatefulWidget {
  CustomMenu1();

  @override
  _CustomMenu1State createState() => _CustomMenu1State();
}

class _CustomMenu1State extends State<CustomMenu1> {
  bool isExpandedImoveis = false;

  @override
  void initState() {
    super.initState();
  }

  void handleExpansionImoveisChanged(bool expanded) {
    setState(() {
      isExpandedImoveis = expanded;
    });
  }

  void logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LandingPage(),
        ),
      );
    } catch (e) {
      print('Erro ao sair da conta.');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 900;

    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            width: 300,
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              gradient: LinearGradient(
                colors: [Color(0xFF7B0000), Color(0xFF7B0000)], // Modify as needed
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned(
            top: 100,
            child: CircleAvatar(
              radius: 57,
              backgroundColor: Color.fromARGB(255, 239, 243, 242),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xFF466B66),
                ),
            ),
          ),
        ],
      ),
      ),
          ListTile(
            leading: Icon(Icons.food_bank, color: Color(0xFF466B66)),
            title: const Text('Refeições'),
            onTap: () {
               Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RefeicoesPage()),
                    );
            },
          ),
          ListTile(
            leading: Icon(Icons.monetization_on, color: Color(0xFF7B0000)),
            title: const Text('Entradas/Saida'),
            onTap: () {
               Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EntradasPage()),
                    );
            },
          ),
          ListTile(
            leading: Icon(Icons.handshake, color: Color.fromARGB(255, 189, 202, 2)),
            title: const Text('Doações'),
            onTap: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DoacoesPage()),
                    );
            },
          ),
          Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.logout, color: Color(0xFF466B66)),
                    title: const Text('Log Out'),
                    onTap: logOut,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

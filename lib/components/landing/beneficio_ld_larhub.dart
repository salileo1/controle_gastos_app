import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../pages/auth/checkpage.dart';


class BeneficioLandLarHub extends StatelessWidget {
  final int tipoPagina;
  final Map<String, Map<String, String>> variaveis;

  const BeneficioLandLarHub(
      {Key? key, required this.tipoPagina, required this.variaveis})
      : super(key: key);

      Future<void> _openSocialMediaLink() async {
    final Uri _url = Uri.parse('https://www.instagram.com/ajudepelotas2024/'); // Substitua pela URL externa desejada
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }


  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 900;


    return Container(
      height: isSmallScreen ? 600 : 500,
      color: Colors.white,
      alignment: Alignment.center,
      child: isSmallScreen
          ? Padding(
              padding: EdgeInsets.all(40),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _buildSmallLayout(context),),
            )
          : Padding(
              padding: EdgeInsets.all(40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _buildNormalLayout(isSmallScreen,context)
                    
              ),
            ),
    );
  }

  List<Widget> _buildNormalLayout(bool isSmallScreen, BuildContext context) {
    double listHeight = isSmallScreen ? 300.0 : double.infinity;

    return [
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              variaveis["beneficio_0"]!["titulo_beneficio_0"]!,
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              variaveis["beneficio_0"]!["subtitulo_beneficio_0"]!,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: Container(
                height: listHeight, 
                child: ListView(
                  children: [
                    ListTile(
                      leading: Icon(Icons.check_box_outlined),
                      title: Text(
                          variaveis["beneficio_0"]!["lista_beneficio_0_1"]!),
                    ),
                    ListTile(
                      leading: Icon(Icons.check_box_outlined),
                      title: Text(
                          variaveis["beneficio_0"]!["lista_beneficio_0_2"]!),
                    ),
                    ElevatedButton(
                      onPressed: () => {
                        _openSocialMediaLink()
                      },
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.black,
                        elevation: 10.0,
                        minimumSize: Size(200, 60),
                        backgroundColor: Color.fromARGB(255, 129, 1, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(variaveis["beneficio_0"]!["texto_botao"]!, style:TextStyle(color: Colors.white) ),
                    ),
                  ],
                ),
              ),
            ),
            
          ],
        ),
      ),
      SizedBox(width: 20),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Precisa de ajuda?',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                height: listHeight, // Define a altura da lista aqui
                child: ListView(
                  children: [
                    ListTile(
                      
                      title: Text(
                        'Nosso direct está aberto para acolher e organizar demandas!'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }

 List<Widget> _buildSmallLayout(BuildContext context) {
    double listHeight = 337.0;

    return [
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              variaveis["beneficio_0"]!["titulo_beneficio_0"]!,
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              variaveis["beneficio_0"]!["subtitulo_beneficio_0"]!,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 15),
            Container(
              height: listHeight,
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.check_box_outlined),
                    title: Text(variaveis["beneficio_0"]!["lista_beneficio_0_1"]!),
                  ),
                  ListTile(
                    leading: Icon(Icons.check_box_outlined),
                    title: Text(variaveis["beneficio_0"]!["lista_beneficio_0_2"]!),
                  ),
                  ElevatedButton(
                    onPressed: _openSocialMediaLink,
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.black,
                      elevation: 10.0,
                      minimumSize: Size(200, 60),
                      backgroundColor: Color.fromARGB(255, 129, 1, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      variaveis["beneficio_0"]!["texto_botao"]!,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
              Text(
              'Precisa de ajuda?',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: listHeight,
              child: Text(
                  'Nosso direct está aberto para acolher e organizar demandas!', style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 15,
              ),),
              
            ),
                ],
              ),
            ),
            
          ],
        ),
      ),
    ];
  }
}
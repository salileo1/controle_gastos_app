import 'package:flutter/material.dart';

import '../../pages/auth/checkpage.dart';


class AppBarLandLarHub extends StatelessWidget implements PreferredSizeWidget {
  final Map<String, Map<String, String>> variaveis;
  const AppBarLandLarHub({
    Key? key,
    required this.variaveis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int corInt = int.parse(variaveis["cores"]!["corPrincipal"]!);
    Color cor = Color(corInt);
    return AppBar(
      title: Padding(
        padding: EdgeInsets.only(left: 50.0), // Adiciona padding à esquerda
        child: FittedBox(
                  fit: BoxFit.contain,
                  child: SizedBox(
                    height: 150, // Altura personalizada da imagem
                    child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/ajude-pelotas.appspot.com/o/2.png?alt=media&token=595a4036-13a0-4f3d-a4e2-1a9306721fc1',
                    ),
                  ),
                ),
      ),
      toolbarHeight: 500,
      backgroundColor: cor,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 8, top: 8, bottom: 8),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => checkPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              shadowColor: Color.fromARGB(255, 255, 253, 253),
              fixedSize: Size(150, 30),
              elevation: 10.0,
              backgroundColor: Color.fromARGB(255, 184, 54, 54),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              variaveis["appBar"]!["botao1"]!,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

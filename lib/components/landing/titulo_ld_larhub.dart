import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class TituloLandLarHub extends StatelessWidget {
  final Map<String, Map<String, String>> variaveis;

  const TituloLandLarHub({
    Key? key,
    required this.variaveis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 900;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20),
      height: isSmallScreen
          ? 800
          : 650,
      child:isSmallScreen ? 
      Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 600,
                    width: 450,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 201, 4, 4),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Image.network(
                     '',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        variaveis['titulo']!['titulo_1']!,
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      if (variaveis['titulo']!['subtitulo_1']!.isNotEmpty)
                        Text(
                          variaveis['titulo']!['subtitulo_1']!,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),  
                    ],
                  ),
                ),
              ],
            )
      :Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        variaveis['titulo']!['titulo_1']!,
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      if (variaveis['titulo']!['subtitulo_1']!.isNotEmpty)
                        Text(
                          variaveis['titulo']!['subtitulo_1']!,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                          ),
                        ),  
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 600,
                    width: 450,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 201, 4, 4),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Image.network(
                     'https://www.google.com/url?sa=i&url=https%3A%2F%2Fconceito.de%2Fdinheiro&psig=AOvVaw1xRF8ONQ7iTfH4HOmOnj0k&ust=1720149547197000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCMig6NX6iocDFQAAAAAdAAAAABAE',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

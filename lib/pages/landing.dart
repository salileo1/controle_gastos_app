import 'package:controle_gasto/components/landing/refeicoes_component.dart';
import 'package:controle_gasto/pages/entradas/entradas_list_view.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/landing/beneficio_ld_larhub.dart';
import '../components/landing/customAppBar_ld_larhub.dart';
import '../components/landing/entradas_component.dart';
import '../components/landing/titulo_ld_larhub.dart';


class LandingPage extends StatelessWidget {
  LandingPage({
    Key? key,
  }) : super(key: key);

 final Map<String, Map<String, String>> variaveis = {
    "cores": {
      "corPrincipal": "0xFFF7F7F7",
    },
    "appBar": {
      "botao1": "LOGIN",
    },
    'titulo': {
      "titulo_1": 'QUEM SOMOS/NOSSO PROPÓSITO',
      "subtitulo_1":
          'App de organização de controle de gastos, quantidade de refeições diarias separadas por locais e doações.',
      "texto_1": "",
    },
    'beneficio_0': {
      "tag": "",
      "titulo_beneficio_0": 'Como ajudar?',
      "subtitulo_beneficio_0":
          'Doando no nosso PIX! Com o valor compramos insumos para as refeições e demais itens necessários. ',
      "lista_beneficio_0_1":
          'PIX: Pix_ficticio',
      "lista_beneficio_0_2":
          'Doações presenciais, entrar em contato via instagram',
      "lista_beneficio_0_3":
          '',
      "texto_botao": '@instagramOng',
      
    },
    'beneficio_1': {
      "tag": "",
      "titulo_beneficio_1": 'Acompanhe suas negociações em tempo real',
      "subtitulo_beneficio_1":
          'Com LarHub, você pode acompanhar todas as etapas das negociações, desde o primeiro contato até o fechamento do negócio.',
      "lista_beneficio_0_1":
          '+5,000 corretores já estão utilizando LarHub.',
      "lista_beneficio_0_2":
          'Tenha mais controle e feche mais negócios.',
      "lista_beneficio_0_3":
          'Mantenha-se organizado e nunca perca uma oportunidade.',
      "texto_botao": 'Experimente agora',
      "link_imagem":
          "https://s2.glbimg.com/PVs2KZyLRu5vsGAd9ORfNNbNKSQ=/e.glbimg.com/og/ed/f/original/2015/06/30/foto-620-455.jpg",
    },
    "footer": {
      "politica": "Política de privacidade",
      "cookies": "Política de cookies",
      "termos": "Termos e Condições",
    }
  };

  

  @override
  Widget build(BuildContext context) {
    int corPrincipal = int.parse(variaveis["cores"]!["corPrincipal"]!);
    Color corPrincipalColor = Color(corPrincipal);
    return Scaffold(
      appBar: AppBarLandLarHub(variaveis: variaveis),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            // Adicione um SingleChildScrollView
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color: corPrincipalColor,
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TituloLandLarHub(variaveis: variaveis),
                        BeneficioLandLarHub( tipoPagina: 0, variaveis: variaveis),
                        EntradasComponent(),
                        RefeicoesComponent(),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
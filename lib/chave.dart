import 'package:flutter/material.dart';
import 'package:quiz_code/contants.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class ChavePage extends StatefulWidget {
  final String chave;
  const ChavePage({super.key, required this.title, required this.chave});

  final String title;

  @override
  State<ChavePage> createState() => _ChavePageState();
}

class _ChavePageState extends State<ChavePage> {
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          //imagem de fundo from assets/Fundo.png
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Fundo.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 500),
                      padding: const EdgeInsets.all(24),
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.18,
                      ), //30% do topo da tela
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const SizedBox(height: 80),

                          Container(
                            width: 250,
                            height: 80,
                            //imagem de fundo from assets/Fundo.png
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/PIN_FUNDO.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                widget.chave,
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 58,
                                  fontFamily: "Helvetica",
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 3),

                          //alinhar o texto no centro
                          Text.rich(
                            textAlign: TextAlign.center,

                            TextSpan(
                              text: 'Válido somente 1 vez!',
                              style: TextStyle(
                                color: Colors.white38,
                                fontSize: 14,
                                fontFamily: "Helvetica",
                              ),
                            ),
                          ),

                          const SizedBox(height: 60),

                          Text.rich(
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              fontFamily: "Helvetica",
                            ),
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      'Para participar, Informe a chave no game 2CX.',
                                ),
                                TextSpan(text: '\n'),
                                TextSpan(
                                  text:
                                      'A ativação dá direito a uma única vez por dia.',
                                ),
                                TextSpan(text: '\n'),
                                TextSpan(
                                  text:
                                      'Tire print da tela para não esquecer a chave.',
                                ),
                                TextSpan(text: '\n'),
                                TextSpan(
                                  text:
                                      'Dúvidas, procure nosso time 2CX. Boa sorte!',
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 60),

                          //logo 2cx
                          SizedBox(
                            width: double.infinity,
                            child: Image(
                              width: double.infinity,
                              height: 30,
                              image: AssetImage('assets/LOGO_01.png'),
                            ),
                          ),
                          const SizedBox(height: 30),
                          //
                          InkWell(
                            onTap: () async {
                              //abrir link https://api.whatsapp.com/send?phone=551133207900
                              url_launcher.launchUrl(Uri.parse(urlWhatsapp));
                            },
                            child: Container(
                              width: double.infinity,
                              height: 46,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/TELA03/botao_03.png', //quiz-code/assets/TELA03/botao_03.png
                                  ),
                                  fit: BoxFit.contain,
                                ),
                              ),
                              //event click
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // logo alamidia fixed in bottom, independente do tamanho da tela
              SizedBox(
                width: double.infinity,
                child: Image(
                  width: double.infinity,
                  height: 100,
                  image: AssetImage('assets/ALAMIDIA_LOGO.png'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

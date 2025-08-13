import 'package:flutter/material.dart';
import 'package:quiz_code/registro.dart';

class AvisoPage extends StatefulWidget {
  const AvisoPage({super.key, required this.title});

  final String title;

  @override
  State<AvisoPage> createState() => _AvisoPageState();
}

class _AvisoPageState extends State<AvisoPage> {
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
                      margin: EdgeInsets.only(top: 70),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const SizedBox(height: 80),

                          Image.asset(
                            'assets/LOGO_01.png',
                            width: double.infinity,
                          ),
                          Container(
                            height: 100,
                            constraints: const BoxConstraints(
                              maxHeight: 200,
                              minHeight: 80,
                            ),
                          ),

                          //alinhar o texto no centro
                          Text.rich(
                            textAlign: TextAlign.center,

                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                              fontFamily: "Helvetica",
                            ),

                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      'Para concorrer ao brinde, Registre-se!',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                    fontFamily: "Helvetica",
                                  ),
                                ),
                                TextSpan(
                                  text: '\n',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                    fontFamily: "Helvetica",
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'Os dados são exclusivos da 2CX, não\n compartilhado com nenhum parceiro,\n terceiro, internet, tv, rádio e similares.',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                    fontFamily: "Helvetica",
                                  ),
                                ),
                                TextSpan(
                                  text: '\n',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                    fontFamily: "Helvetica",
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'Toque em Concorrer e continue para\n aceitar os Termos de Serviço.',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                    fontFamily: "Helvetica",
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 60),
                          InkWell(
                            onTap: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RegisterPage(title: 'Registro'),
                                ),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              height: 46,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/TELA01/botao_01.png',
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
              // SizedBox(
              //   width: double.infinity,
              //   child: Image(
              //     width: double.infinity,
              //     height: 100,
              //     image: AssetImage('assets/ALAMIDIA_LOGO.png'),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

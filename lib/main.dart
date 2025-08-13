import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:quiz_code/firebaseManager.dart';
import 'package:quiz_code/firebase_options.dart';
import 'package:quiz_code/aviso.dart';
import 'package:quiz_code/usuarioModel.dart';
import 'package:quiz_code/config/env_config.dart';

//usuario global
Usuario? usuario;
String deviceType = 'Web';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Carregar variáveis de ambiente apenas na web
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseManager().loginAnonimo();

  //

  //permitir que o usuario seja salvo no firebase offline
  // Firebase Realtime Database persistence is enabled by default
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz Code',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const AvisoPage(title: 'Aviso'),
    );
  }
}

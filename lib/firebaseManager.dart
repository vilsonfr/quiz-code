//gerar codigo unico de 6 caracteres e salvar no firebase, salvar no MEI do dispositivo, para nao ter outro com o mesmo codigo

import 'dart:convert';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:quiz_code/usuarioModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseManager {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref(
    "quiz-slot",
  );

  Future<int> generateUniqueCode() async {
    // Gerar um código aleatório de 4 digitos
    final random = Random.secure();
    final values = List<int>.generate(4, (i) => random.nextInt(10));
    final code = values.join('');
    return int.parse(code);
  }

  //verificar se o codigo ja existe no firebase
  //evitar que o codigo seja salvo no firebase se ja existir
  Future<bool> verificarCodigo(int codigo) async {
    final codeRef = _databaseReference
        .child('usuarios/codigo')
        .child(codigo.toString());

    final snapshot = await codeRef.get();
    return snapshot.exists;
  }

  //salvar o usuario no firebase
  Future<bool> saveUsuarioToFirebase(Usuario usuario) async {
    try {
      final codeRef = _databaseReference.child('usuarios').push();

      await codeRef.set(usuario.toJson());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  //verificar se o usuario ja existe no firebase
  Future<bool> verificarUsuario(String email) async {
    try {
      // Query all users and check if any have the same email
      final usersRef = _databaseReference.child('usuarios');
      final snapshot = await usersRef.get();

      if (snapshot.exists) {
        final Map<dynamic, dynamic> users =
            snapshot.value as Map<dynamic, dynamic>;

        for (var user in users.values) {
          if (user is Map && user['email'] == email) {
            return true; // User with this email already exists
          }
        }
      }

      return false; // No user with this email found
    } catch (e) {
      if (kDebugMode) {
        print('Error checking user: $e');
      }
      return false;
    }
  }

  //login com email e senha

  Future<UserCredential> loginWithEmailAndPassword(
    String emailAddress,
    String password,
  ) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      ); 
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
      }
      rethrow;
    }
  }

  //login anonimo
  Future<UserCredential> loginAnonimo() async {
    final credential = await FirebaseAuth.instance.signInAnonymously();
    return credential;
  }

  //login com email e senha
  Future<void> createWithEmailAndPassword(
    String emailAddress,
    String password,
  ) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

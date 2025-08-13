import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static String get firebaseEmail {
    if (kIsWeb) {
      // Para web, usar arquivo .env
      return dotenv.env['FIREBASE_EMAIL'] ?? '';
    } else {
      // Para mobile, usar valores hardcoded (seguro pois ninguém tem acesso)
      return 'vilsonfreitaspacheco@gmail.com';
    }
  }

  static String get firebasePassword {
    if (kIsWeb) {
      // Para web, usar arquivo .env
      return dotenv.env['FIREBASE_PASSWORD'] ?? '';
    } else {
      // Para mobile, usar valores hardcoded (seguro pois ninguém tem acesso)
      return 'A#326587fRT';
    }
  }

  static bool get hasValidCredentials {
    return firebaseEmail.isNotEmpty && firebasePassword.isNotEmpty;
  }
} 
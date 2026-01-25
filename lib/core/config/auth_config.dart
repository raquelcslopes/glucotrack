import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthConfig {
  static String get googleWebClientId => 
      dotenv.env['GOOGLE_WEB_CLIENT_ID'] ?? '';
  
  static String get googleServerClientId => 
      dotenv.env['GOOGLE_SERVER_CLIENT_ID'] ?? '';
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.googleSignIn,
  });

  @override
  Future<UserCredential> signInWithGoogle() async {
    // 🔹 Usa a instância do DI (não criar nova)
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    // 🔹 Usuário cancelou o login
    if (googleUser == null) {
      throw Exception('Login cancelado pelo usuário');
    }

    // 🔹 Obter credenciais do Google
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // 🔹 Criar credencial Firebase
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken, // existe no v6.x
    );

    // 🔹 Logar no Firebase e retornar
    return await firebaseAuth.signInWithCredential(credential);
  }
}

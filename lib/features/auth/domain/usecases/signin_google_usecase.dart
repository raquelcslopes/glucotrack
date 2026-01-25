import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/features/auth/domain/repositories/auth_repository.dart';

class SignInWithGoogle {
  final AuthRepository repository;

  SignInWithGoogle(this.repository);

  Future<UserCredential> call() {
    return repository.signInWithGoogle();
  }
}

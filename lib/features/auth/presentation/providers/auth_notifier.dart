import 'package:flutter_app/features/auth/domain/usecases/signin_google_usecase.dart';
import 'package:flutter_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AuthState {}
class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState {}
class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}


class AuthNotifier extends StateNotifier<AuthState> {
  final SignInWithGoogle signInWithGoogle;
  AuthNotifier(this.signInWithGoogle) : super(AuthInitial());

  Future<void> login() async {
    state = AuthLoading();
    try {
      await signInWithGoogle();
      state = AuthSuccess();
    } catch (e) {
      state = AuthError(e.toString());
    }
  }
}

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final signInUseCase = ref.watch(signInWithGoogleProvider); 
  return AuthNotifier(signInUseCase);
});


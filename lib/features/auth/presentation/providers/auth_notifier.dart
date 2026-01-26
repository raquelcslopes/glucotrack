import 'package:flutter_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_app/features/auth/domain/usecases/signin_google_usecase.dart';
import 'package:flutter_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter_app/features/user/domain/entities/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

// -------------------- Auth States --------------------
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;
  AuthAuthenticated(this.user);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

// -------------------- Mapper --------------------
User mapFirebaseUserToDomain(fb.User firebaseUser) {
  return User(
    id: firebaseUser.uid,
    name: firebaseUser.displayName ?? '',
    height: 0,
    weight: 0,
    imc: 0,
    takesInsulin: false,
    isCompelete: false,
  );
}

// -------------------- AuthNotifier --------------------
class AuthNotifier extends StateNotifier<AuthState> {
  final SignInWithGoogle signInWithGoogle;
  final AuthRepository repository;

  AuthNotifier({required this.signInWithGoogle, required this.repository})
    : super(AuthInitial()) {
    _checkLoggedIn();
  }

  Future<void> _checkLoggedIn() async {
    final uid = await repository.getCachedUserId();
    if (uid != null) {
      state = AuthAuthenticated(
        User(
          id: uid,
          name: '',
          height: 0,
          weight: 0,
          imc: 0,
          takesInsulin: false,
          isCompelete: false,
        ),
      );
    }
  }

  Future<void> login() async {
    state = AuthLoading();
    try {
      final response = await signInWithGoogle();
      final firebaseUser = response.user;
      if (firebaseUser == null) throw Exception('User is null');

      final domainUser = mapFirebaseUserToDomain(firebaseUser);
      state = AuthAuthenticated(domainUser);
    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  Future<void> logout() async {
    state = AuthInitial();
    await repository.signOut();
  }
}

// -------------------- Provider --------------------
final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((
  ref,
) {
  final signInUseCase = ref.watch(signInWithGoogleProvider);
  final repository = ref.watch(authRepositoryProvider);
  return AuthNotifier(signInWithGoogle: signInUseCase, repository: repository);
});

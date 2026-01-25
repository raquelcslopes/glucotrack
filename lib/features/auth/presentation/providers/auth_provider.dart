import 'package:flutter_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_app/features/auth/data/repositories/auth_local_datasource.dart';
import 'package:flutter_app/features/auth/data/repositories/auth_remote_datasource_impl.dart';
import 'package:flutter_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_app/features/auth/domain/usecases/loggedin_usecase.dart';
import 'package:flutter_app/features/auth/domain/usecases/signin_google_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/datasources/auth_local_datasource.dart';

// SharedPreferences provider
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences not initialized');
});

// RemoteDataSource provider
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl(
    firebaseAuth: FirebaseAuth.instance,
    googleSignIn: GoogleSignIn(scopes: ['email']),
  );
});

// LocalDataSource provider
final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return AuthLocalDataSourceImpl(prefs);
});

// Repository provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.watch(authRemoteDataSourceProvider),
    localDataSource: ref.watch(authLocalDataSourceProvider),
  );
});

// UseCases providers
final signInWithGoogleProvider = Provider<SignInWithGoogle>((ref) {
  return SignInWithGoogle(ref.watch(authRepositoryProvider));
});

final isLoggedInProvider = Provider<IsLoggedIn>((ref) {
  return IsLoggedIn(ref.watch(authRepositoryProvider));
});

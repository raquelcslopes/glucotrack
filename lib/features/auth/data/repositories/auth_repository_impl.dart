import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:flutter_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<UserCredential> signInWithGoogle() async {
    final userCredential = await remoteDataSource.signInWithGoogle();
    final user = userCredential.user;
    if (user != null) {
      await localDataSource.cacheUserId(user.uid);
    }
    return userCredential;
  }

  @override
  Future<bool> isLoggedIn() async {
    return await localDataSource.getCachedUserId() != null;
  }

  @override
  Future<void> signOut() async {
    await localDataSource.clear();
  }

  @override
  Future<String?> getCachedUserId() async {
    return localDataSource.getCachedUserId();
  }
}

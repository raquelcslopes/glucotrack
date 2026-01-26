import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/features/user/data/datasources/user_local_datasource.dart';
import 'package:flutter_app/features/user/data/repositories/user_local_datasource_impl.dart';
import 'package:flutter_app/features/user/data/repositories/user_remote_datasource_impl.dart';
import 'package:flutter_app/features/user/domain/usecases/create_user_usecase.dart.dart';
import 'package:flutter_app/features/user/domain/usecases/get_user_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/features/user/data/datasources/user_datasource.dart';
import 'package:flutter_app/features/user/data/repositories/user_repository_impl.dart';
import 'package:flutter_app/features/user/domain/repositories/user_repository_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences must be initialized in main()');
});

// Remote DataSource (Firestore)
final userRemoteDataSourceProvider = Provider<UserDatasource>((ref) {
  final firestore = ref.watch(firestoreProvider);
  return UserRemoteDatasourceImpl(firestore);
});

// Local DataSource (SharedPreferences)
final userLocalDataSourceProvider = Provider<UserLocalDatasource>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return UserLocalDatasourceImpl(sharedPreferences);
});

final userRepositoryProvider = Provider<UserRepositoryInterface>((ref) {
  final remoteDataSource = ref.watch(userRemoteDataSourceProvider);
  final localDataSource = ref.watch(userLocalDataSourceProvider);
  return UserRepositoryImpl(
    remoteDatasource: remoteDataSource,
    localDatasource: localDataSource,
  );
});

final createUserUseCaseProvider = Provider<CreateUserUsecase>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return CreateUserUsecase(repository);
});

final getUserUseCaseProvider = Provider<GetUserUsecase>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return GetUserUsecase(repository);
});

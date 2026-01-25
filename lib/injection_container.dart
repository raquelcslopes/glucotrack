/* import 'package:flutter_app/core/config/auth_config.dart';
import 'package:flutter_app/features/auth/data/repositories/auth_local_datasource.dart';
import 'package:flutter_app/features/auth/data/repositories/auth_remote_datasource_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'features/auth/data/datasources/auth_local_datasource.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/signin_google_usecase.dart';
import 'features/auth/domain/usecases/loggedin_usecase.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  final prefs = await SharedPreferences.getInstance();

  getIt.registerLazySingleton<SharedPreferences>(() => prefs);
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  final googleSignIn = GoogleSignIn.instance;
  await googleSignIn.initialize();

  getIt.registerLazySingleton<GoogleSignIn>(() => googleSignIn);

  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(getIt<SharedPreferences>()),
  );

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: getIt<FirebaseAuth>(),
      googleSignIn: getIt<GoogleSignIn>(),
    ),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: getIt<AuthRemoteDataSource>(),
      localDataSource: getIt<AuthLocalDataSource>(),
    ),
  );

  getIt.registerLazySingleton(() => SignInWithGoogle(getIt<AuthRepository>()));

  getIt.registerLazySingleton(() => IsLoggedIn(getIt<AuthRepository>()));
}
 */
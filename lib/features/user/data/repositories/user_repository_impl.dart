import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter_app/features/user/data/datasources/user_datasource.dart';
import 'package:flutter_app/features/user/data/datasources/user_local_datasource.dart';
import 'package:flutter_app/features/user/data/dtos/user_dto.dart';
import 'package:flutter_app/features/user/domain/entities/user.dart';
import 'package:flutter_app/features/user/domain/repositories/user_repository_interface.dart';

class UserRepositoryImpl implements UserRepositoryInterface {
  final UserDatasource remoteDatasource; // Firestore
  final UserLocalDatasource localDatasource; // SharedPreferences

  UserRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  @override
  Future<void> createUser(User user) async {
    try {
      final userDto = UserDto(
        userId: user.id,
        name: user.name,
        profilePic: user.profilePic,
        height: user.height,
        weight: user.weight,
        imc: user.imc,
        takesInsulin: user.takesInsulin,
        insulinScheme: user.insulinScheme,
        isComplete: user.isCompelete,
      );

      await localDatasource.saveUser(userDto);

      try {
        await remoteDatasource.createUser(userDto);
      } catch (e) {
        print('Error: Not possible to save in Firestore: $e');
        // Mesmo assim, o user está salvo localmente
      }
    } on FirebaseException catch (e) {
      throw Exception('Firebase Error: ${e.message}');
    } catch (e) {
      throw Exception('Error creating user: $e');
    }
  }

  @override
  Future<User> getUser(String userId) async {
    try {
      final localUser = await localDatasource.getUser();

      if (localUser != null) {
        if (userId.isNotEmpty) {
          _syncFromRemote(userId);
        }

        return User(
          id: localUser.userId,
          name: localUser.name,
          profilePic: localUser.profilePic,
          height: localUser.height,
          weight: localUser.weight,
          imc: localUser.imc,
          takesInsulin: localUser.takesInsulin,
          insulinScheme: localUser.insulinScheme,
          isCompelete: localUser.isComplete,
        );
      }

      if (userId.isEmpty) {
        throw Exception('No user found in cache');
      }

      final remoteUser = await remoteDatasource.getUser(userId);

      await localDatasource.saveUser(remoteUser);

      return User(
        id: remoteUser.userId,
        name: remoteUser.name,
        profilePic: remoteUser.profilePic,
        height: remoteUser.height,
        weight: remoteUser.weight,
        imc: remoteUser.imc,
        takesInsulin: remoteUser.takesInsulin,
        insulinScheme: remoteUser.insulinScheme,
        isCompelete: remoteUser.isComplete,
      );
    } on FirebaseException catch (e) {
      throw Exception('Firebase Error: ${e.message}');
    } catch (e) {
      throw Exception('Error loading user: $e');
    }
  }

  Future<void> _syncFromRemote(String userId) async {
    try {
      final remoteUser = await remoteDatasource.getUser(userId);
      await localDatasource.saveUser(remoteUser);
    } catch (e) {
      print('Error Firestore: $e');
    }
  }
}

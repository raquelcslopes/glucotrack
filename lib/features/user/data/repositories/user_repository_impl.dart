import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter_app/features/user/data/datasources/user_datasource.dart';
import 'package:flutter_app/features/user/data/dtos/user_dto.dart';
import 'package:flutter_app/features/user/domain/entities/user.dart';
import 'package:flutter_app/features/user/domain/repositories/user_repository_interface.dart';

class UserRepositoryImpl implements UserRepositoryInterface {
  final UserDatasource userDatasource;

  UserRepositoryImpl(this.userDatasource);

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
      );

      await userDatasource.createUser(userDto);
    } on FirebaseException catch (e) {
      throw Exception('Firebase Error: ${e.message}');
    } catch (e) {
      throw Exception('Error creating user: $e');
    }
  }

  @override
  Future<User> getUser(String userId) async {
    try {
      final user = await userDatasource.getUser(userId);

      final userEntity = User(
        id: user.userId,
        name: user.name,
        height: user.height,
        weight: user.weight,
        imc: user.imc,
        takesInsulin: user.takesInsulin,
      );

      return userEntity;
    } on FirebaseException catch (e) {
      throw Exception('Firebase Error: ${e.message}');
    } catch (e) {
      throw Exception('Error loading user');
    }
  }
}

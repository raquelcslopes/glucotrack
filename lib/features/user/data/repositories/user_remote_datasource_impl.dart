import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/features/user/data/datasources/user_datasource.dart';
import 'package:flutter_app/features/user/data/dtos/user_dto.dart';

class UserRemoteDatasourceImpl implements UserDatasource {
  final FirebaseFirestore firestore;

  UserRemoteDatasourceImpl(this.firestore);

  static const String _collectionName = 'users';

  CollectionReference get _usersCollection =>
      firestore.collection(_collectionName);

  @override
  Future<void> createUser(UserDto user) async {
    try {
      await _usersCollection.doc(user.userId).set(user.toMap());

      print('✅ user created! ${user.userId}');
    } on FirebaseException catch (e) {
      print('❌ Firebase error: $e');
      throw FirebaseException(
        plugin: 'cloud_firestore',
        message: e.message ?? 'Error crating user',
        code: e.code,
      );
    } catch (e) {
      print('❌ Error: $e');
      throw Exception('Error: $e');
    }
  }

  @override
  Future<UserDto> getUser(String userId) async {
    try {
      final doc = await _usersCollection.doc(userId).get();

      if (!doc.exists) {
        throw FirebaseException(
          plugin: 'cloud_firestore',
          message: 'User not found',
          code: 'not-found',
        );
      }

      final userDto = UserDto.fromFirestore(doc);

      print('✅ User found: ${userDto.name}');
      return userDto;
    } on FirebaseException catch (e) {
      print('❌ Firebase Error: ${e.message}');
      throw FirebaseException(
        plugin: 'cloud_firestore',
        message: e.message ?? 'Error loading user',
        code: e.code,
      );
    } catch (e) {
      print('❌ Error: $e');
      throw Exception('Error: $e');
    }
  }
}

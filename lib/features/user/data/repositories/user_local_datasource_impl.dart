// lib/features/user/data/datasources/user_local_datasource.dart
import 'package:flutter_app/features/user/data/datasources/user_local_datasource.dart';
import 'package:flutter_app/features/user/data/dtos/user_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserLocalDatasourceImpl implements UserLocalDatasource {
  final SharedPreferences sharedPreferences;
  static const String USER_KEY = 'CACHED_USER';

  UserLocalDatasourceImpl(this.sharedPreferences);

  @override
  Future<void> saveUser(UserDto user) async {
    final jsonString = json.encode(user.toJson());
    await sharedPreferences.setString(USER_KEY, jsonString);
  }

  @override
  Future<UserDto?> getUser() async {
    final jsonString = sharedPreferences.getString(USER_KEY);
    if (jsonString != null) {
      final jsonMap = json.decode(jsonString);
      return UserDto.fromJson(jsonMap);
    }
    return null;
  }
}

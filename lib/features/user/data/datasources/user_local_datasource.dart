import 'package:flutter_app/features/user/data/dtos/user_dto.dart';

abstract class UserLocalDatasource {
  Future<void> saveUser(UserDto user);
  Future<UserDto?> getUser();
}

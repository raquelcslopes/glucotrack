import 'package:flutter_app/features/user/data/dtos/user_dto.dart';

abstract class UserDatasource {
  Future<void> createUser(UserDto user);
  Future<UserDto> getUser(String userId);
}

import 'package:flutter_app/features/user/domain/entities/user.dart';
import 'package:flutter_app/features/user/domain/repositories/user_repository_interface.dart';

class GetUserUsecase {
  final UserRepositoryInterface repo;

  GetUserUsecase(this.repo);

  Future<User> getUSer(String id) {
    return repo.getUser(id);
  }
}

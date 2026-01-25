import 'package:flutter_app/features/user/domain/entities/user.dart';
import 'package:flutter_app/features/user/domain/repositories/user_repository_interface.dart';

class CreateUserUsecase {
  final UserRepositoryInterface repo;

  CreateUserUsecase(this.repo);

  Future<void> createUser(User user) {
    return repo.createUser(user);
  }
}

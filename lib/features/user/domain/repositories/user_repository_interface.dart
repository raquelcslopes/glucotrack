import '../entities/user.dart';

abstract class UserRepositoryInterface {
  Future<void> createUser(User user);
  Future<User> getUser(String userId);
}

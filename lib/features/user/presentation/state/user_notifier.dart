import 'package:flutter_app/features/user/domain/usecases/create_user_usecase.dart.dart';
import 'package:flutter_app/features/user/domain/usecases/get_user_usecase.dart';
import 'package:flutter_app/features/user/presentation/state/user_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/features/user/domain/entities/user.dart';

class UserNotifier extends StateNotifier<UserState> {
  final CreateUserUsecase _createUserUseCase;
  final GetUserUsecase _getUserUseCase;

  UserNotifier({
    required CreateUserUsecase createUserUseCase,
    required GetUserUsecase getUserUseCase,
  }) : _createUserUseCase = createUserUseCase,
       _getUserUseCase = getUserUseCase,
       super(const UserState.initial());

  Future<void> loadCachedUser() async {
    try {
      final user = await _getUserUseCase.getUSer.call('');

      if (user != null) {
        state = state.copyWith(user: user);
      }
    } catch (e) {
      print('No user cache: $e');
    }
  }

  Future<void> createUser(User user) async {
    state = state.copyWith(isLoading: true).clearError();

    try {
      await _createUserUseCase.createUser.call(
        User(
          id: user.id,
          name: user.name,
          profilePic: user.profilePic,
          height: user.height,
          weight: user.weight,
          imc: user.imc,
          takesInsulin: user.takesInsulin,
          isCompelete: true,
          email: user.email,
        ),
      );

      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> getUser(String userId) async {
    state = state.copyWith(isLoading: true).clearError();

    try {
      final user = await _getUserUseCase.getUSer.call(userId);

      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

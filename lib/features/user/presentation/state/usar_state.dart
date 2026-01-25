import 'package:flutter_app/features/user/domain/entities/user.dart';

class UserState {
  final User? user;
  final bool isLoading;
  final String? errorMessage;

  const UserState({this.user, this.isLoading = false, this.errorMessage});

  const UserState.initial()
    : user = null,
      isLoading = false,
      errorMessage = null;

  UserState.loading() : user = null, isLoading = true, errorMessage = null;

  UserState copyWith({User? user, bool? isLoading, String? errorMessage}) {
    return UserState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  /// Limpar erro
  UserState clearError() {
    return UserState(user: user, isLoading: isLoading, errorMessage: null);
  }
}

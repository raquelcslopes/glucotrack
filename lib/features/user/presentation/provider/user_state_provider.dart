import 'package:flutter_app/features/user/presentation/provider/user_provider.dart';
import 'package:flutter_app/features/user/presentation/state/user_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/features/user/presentation/state/user_notifier.dart';

final userNotifierProvider = StateNotifierProvider<UserNotifier, UserState>((
  ref,
) {
  return UserNotifier(
    createUserUseCase: ref.watch(createUserUseCaseProvider),
    getUserUseCase: ref.watch(getUserUseCaseProvider),
  );
});

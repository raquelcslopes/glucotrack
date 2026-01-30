import 'package:flutter/material.dart';
import 'package:flutter_app/core/router/screen_args.dart';
import 'package:flutter_app/features/glucose/presentation/screen/glucose_regist_screen.dart';
import 'package:flutter_app/features/home/prsentation/screens/home_screen.dart';
import 'package:flutter_app/features/user/presentation/provider/user_state_provider.dart';
import 'package:flutter_app/features/user/presentation/screens/complete_profile_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/presentation/screens/login_screen.dart';

class AppRoutes {
  static const String login = '/';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String glucose = '/glucose-regist';

  static Route<dynamic>? generateRoute(RouteSettings settings, WidgetRef ref) {
    final userState = ref.read(userNotifierProvider);

    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      case profile:
        final args = settings.arguments as ScreenArgs?;

        if (args == null) {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(child: Text('Error loading account')),
            ),
          );
        }

        if (userState.user == null || !userState.user!.isCompelete) {
          return MaterialPageRoute(
            builder: (_) => CompleteProfileScreen(
              userName: args.userName,
              profilePic: args.profilePic,
            ),
          );
        } else {
          return MaterialPageRoute(builder: (_) => HomeScreen());
        }

      case glucose:
        return MaterialPageRoute(builder: (_) => GlucoseRegistScreen());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}

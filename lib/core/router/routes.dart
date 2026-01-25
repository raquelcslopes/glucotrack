import 'package:flutter/material.dart';
import 'package:flutter_app/core/router/screen_args.dart';
import 'package:flutter_app/features/user/presentation/screens/complete_profile_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';

class AppRoutes {
  static const String login = '/';
  static const String home = '/home';
  static const String profile = '/profile';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      /*       case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());*/

      case profile:
        final args = settings.arguments as ScreenArgs?;
        if (args == null) {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(child: Text('Error loading account')),
            ),
          );
        }
        return MaterialPageRoute(
          builder: (_) => CompleteProfileScreen(
            userName: args.userName,
            profilePic: args.profilePic,
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}

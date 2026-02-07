import 'package:flutter/material.dart';
import 'package:flutter_app/core/router/screen_args.dart';
import 'package:flutter_app/features/glucose/presentation/screen/glucose_regist_screen.dart';
import 'package:flutter_app/features/home/prsentation/screens/home_screen.dart';
import 'package:flutter_app/features/symptoms/presentation/screens/regist_symptoms_screen.dart';
import 'package:flutter_app/features/user/presentation/provider/user_state_provider.dart';
import 'package:flutter_app/features/user/presentation/screens/complete_profile_screen.dart';
import 'package:flutter_app/features/auth/presentation/screens/splash_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/presentation/screens/login_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String glucose = '/glucose-regist';
  static const String symptoms = '/symptoms-regist';

  static Route<dynamic>? generateRoute(RouteSettings settings, WidgetRef ref) {
    final userState = ref.read(userNotifierProvider);

    final hasCompleteProfile =
        userState.user != null && userState.user!.isCompelete;

    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case login:
        if (hasCompleteProfile) {
          return MaterialPageRoute(builder: (_) => const HomeScreen());
        }
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case home:
        if (hasCompleteProfile) {
          return MaterialPageRoute(builder: (_) => const HomeScreen());
        }
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case profile:
        final args = settings.arguments as ScreenArgs?;

        if (hasCompleteProfile) {
          return MaterialPageRoute(builder: (_) => const HomeScreen());
        }

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
            email: args.email,
          ),
        );

      case glucose:
        if (hasCompleteProfile) {
          return MaterialPageRoute(builder: (_) => const GlucoseRegistScreen());
        }
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case symptoms:
        if (hasCompleteProfile) {
          return MaterialPageRoute(
            builder: (_) => const RegistSymptomsScreen(),
          );
        }
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}

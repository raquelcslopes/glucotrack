import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/app_theme.dart';
import 'package:flutter_app/features/user/presentation/provider/user_state_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  void _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final userState = ref.read(userNotifierProvider);
    final hasCompleteProfile =
        userState.user != null && userState.user!.isCompelete;

    if (hasCompleteProfile) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      Navigator.of(context).pushReplacementNamed('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.primaryLight,
              ),
              child: Icon(
                Icons.monitor_heart_rounded,
                size: 50,
                color: AppTheme.primaryDark,
              ),
            ),
            const SizedBox(height: 30),

            Text(
              'GlucoTrack',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: AppTheme.primaryLight,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            Text(
              'Manage your glucose, improve your health',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color.fromARGB(196, 232, 243, 241),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),

            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryLight),
            ),
          ],
        ),
      ),
    );
  }
}

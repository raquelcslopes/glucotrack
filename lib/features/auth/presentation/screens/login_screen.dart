import 'package:flutter/material.dart';
import 'package:flutter_app/core/router/routes.dart';
import 'package:flutter_app/core/router/screen_args.dart';
import 'package:flutter_app/core/theme/app_theme.dart';
import 'package:flutter_app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool _isLoading = false;

  Widget _buildDivider() {
    return const Row(
      children: [
        Expanded(child: Divider(thickness: 2, color: AppTheme.primaryLight)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'Secure authentication',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppTheme.primaryMedium,
            ),
          ),
        ),
        Expanded(child: Divider(thickness: 2, color: AppTheme.primaryLight)),
      ],
    );
  }

  Future<void> _logInGoogle() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      final notifier = ref.read(authNotifierProvider.notifier);
      final response = await notifier.signInWithGoogle();

      if (!mounted) return;

      await Navigator.pushNamed(
        context,
        AppRoutes.profile,
        arguments: ScreenArgs(
          userName: response.user?.displayName,
          profilePic: response.user?.photoURL,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // LOGO
                const Icon(
                  Icons.monitor_heart_rounded,
                  size: 50,
                  color: AppTheme.primaryDark,
                  shadows: [
                    Shadow(
                      color: Color.fromARGB(146, 29, 120, 116),
                      blurRadius: 10.0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  'GlucoTrack',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Text(
                  'Empower Your Blood Sugar Journey',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // CARD
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 350),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18.0,
                        vertical: 22,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Welcome',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: AppTheme.primaryDark,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Sign in to continue monitoring your health',
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 30),

                          // BUTTON
                          SizedBox(
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _logInGoogle,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                disabledBackgroundColor: Colors.grey[200],
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 20,
                                ),
                                side: BorderSide(
                                  color: _isLoading
                                      ? Colors.grey
                                      : const Color.fromARGB(
                                          134,
                                          103,
                                          146,
                                          137,
                                        ),
                                  width: 2,
                                ),
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: AppTheme.primaryDark,
                                      ),
                                    )
                                  : Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SvgPicture.asset(
                                          'lib/assets/google.svg',
                                          height: 20,
                                          width: 20,
                                          placeholderBuilder: (context) =>
                                              const SizedBox(
                                                height: 20,
                                                width: 20,
                                              ),
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          'Sign in with Google',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: AppTheme.primaryDark,
                                              ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                          const SizedBox(height: 30),

                          // INFO
                          _buildDivider(),
                          const SizedBox(height: 25),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'By proceeding, you agree to our ',
                              style: Theme.of(context).textTheme.bodySmall,
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Terms of Service',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.primaryDark,
                                      ),
                                ),
                                const TextSpan(text: ' and '),
                                TextSpan(
                                  text: 'Privacy Policy.',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.primaryDark,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                const _SecurityBadge(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SecurityBadge extends StatelessWidget {
  const _SecurityBadge();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.lock_outline_rounded,
          color: AppTheme.primaryDark,
          size: 14,
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            'Your health data is protected and encrypted',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

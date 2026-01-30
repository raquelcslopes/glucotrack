import 'package:flutter/material.dart';
import 'package:flutter_app/core/router/routes.dart';
import 'package:flutter_app/core/router/screen_args.dart';
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

  Widget _buildDivider(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(
          child: Divider(thickness: 2, color: colorScheme.outlineVariant),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'Secure authentication',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.secondary,
            ),
          ),
        ),
        Expanded(
          child: Divider(thickness: 2, color: colorScheme.outlineVariant),
        ),
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
          backgroundColor: Theme.of(context).colorScheme.error,
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
    final colorScheme = Theme.of(context).colorScheme;
    final brightness = Theme.of(context).brightness;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // LOGO
                Icon(
                  Icons.monitor_heart_rounded,
                  size: 50,
                  color: colorScheme.primary,
                  shadows: [
                    Shadow(
                      color: colorScheme.primary.withOpacity(0.5),
                      blurRadius: 10.0,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  'GlucoTrack',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: colorScheme.primary,
                  ),
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
                          Text(
                            'Welcome',
                            style: Theme.of(context).textTheme.headlineLarge
                                ?.copyWith(color: colorScheme.primary),
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
                                backgroundColor: brightness == Brightness.light
                                    ? Colors.white
                                    : colorScheme.surface,
                                disabledBackgroundColor:
                                    colorScheme.outlineVariant,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 20,
                                ),
                                side: BorderSide(
                                  color: _isLoading
                                      ? colorScheme.outline
                                      : colorScheme.secondary,
                                  width: 2,
                                ),
                              ),
                              child: _isLoading
                                  ? SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: colorScheme.primary,
                                        backgroundColor: Colors.transparent,
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
                                                color: colorScheme.primary,
                                              ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                          const SizedBox(height: 30),

                          // INFO
                          _buildDivider(context),
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
                                        color: colorScheme.primary,
                                      ),
                                ),
                                const TextSpan(text: ' and '),
                                TextSpan(
                                  text: 'Privacy Policy.',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: colorScheme.primary,
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
                _SecurityBadge(),
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
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.lock_outline_rounded, color: colorScheme.primary, size: 14),
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

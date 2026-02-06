import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/app_theme.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:url_launcher/url_launcher.dart';

class SosButton extends StatelessWidget {
  const SosButton({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> callEmergency() async {
      try {
        await launchUrl(Uri(scheme: 'tel', path: '112'));
      } catch (e) {
        print('Erro ao fazer chamada: $e');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erro ao abrir chamada')));
      }
    }

    final GlobalKey<SlideActionState> _key = GlobalKey();

    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: SlideAction(
        key: _key,
        onSubmit: () {
          Future.delayed(Duration(seconds: 1), () {
            callEmergency();
            _key.currentState!.reset();
          });
        },
        outerColor: AppTheme.error,
        text: 'Call 112',
      ),
    );
  }
}

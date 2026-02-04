import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/core/router/routes.dart';
import 'package:flutter_app/core/theme/app_theme.dart';
import 'package:flutter_app/features/user/presentation/provider/user_provider.dart';
import 'package:flutter_app/features/user/presentation/provider/user_state_provider.dart';
import 'package:flutter_app/firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final prefs = await SharedPreferences.getInstance();

  await dotenv.load(fileName: ".env");

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const GlucoTrack(),
    ),
  );
}

class GlucoTrack extends ConsumerStatefulWidget {
  const GlucoTrack({super.key});

  @override
  ConsumerState<GlucoTrack> createState() => _GlucoTrackState();
}

class _GlucoTrackState extends ConsumerState<GlucoTrack> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(userNotifierProvider.notifier).loadCachedUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GlucoTrack",
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: (settings) => AppRoutes.generateRoute(settings, ref),
    );
  }
}

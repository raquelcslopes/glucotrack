import 'package:flutter/material.dart';
import 'package:flutter_app/features/glucose/domain/entities/glucose_reading.dart';
import 'package:flutter_app/features/glucose/presentation/provider/glucose_provider.dart';
import 'package:flutter_app/features/home/prsentation/widgets/current_glucose_card.dart';
import 'package:flutter_app/features/home/prsentation/widgets/drawer.dart';
import 'package:flutter_app/features/home/prsentation/widgets/gluco_chart.dart';
import 'package:flutter_app/features/home/prsentation/widgets/header.dart';
import 'package:flutter_app/features/home/prsentation/widgets/selection_card.dart';
import 'package:flutter_app/features/user/presentation/provider/user_state_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  double _calculateAverage(List<GlucoseReading> readings) {
    if (readings.isEmpty) return 0;

    final sum = readings.fold<double>(
      0,
      (prev, reading) => prev + reading.value,
    );
    return sum / readings.length;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userNotifierProvider).user;
    final userName = user!.name;
    final userProfilePic = user.profilePic;

    final readings = ref.watch(glucoseReadingsProvider);

    return Scaffold(
      drawer: DrawerWidget(useName: userName, profilePic: userProfilePic),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(name: userName),
            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text(
                  'Hi, $userName 👋',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text(
                  'How are you feeling today?',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
            SizedBox(height: 20),

            readings.when(
              data: (data) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: CurrentGlucoseCard(
                      currentReading: data.first,
                      averageValue: _calculateAverage(data),
                      isTrendingDown: true,
                    ),
                  ),
                ],
              ),
              loading: () => const CircularProgressIndicator(),
              error: (e, st) => Text('Error: $e'),
            ),
            SizedBox(height: 18),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SelectionCard(
                  icon: Icons.water_drop_outlined,
                  title: 'Check Glucose',
                  subtitle: 'Record new reading',
                  onTap: () => Navigator.pushNamed(context, '/glucose-regist'),
                ),

                SelectionCard(
                  icon: Icons.document_scanner_outlined,
                  title: 'Log Symptoms',
                  subtitle: 'Note how you feel',
                  onTap: () => Navigator.pushNamed(context, 'glucose'),
                ),
              ],
            ),
            SizedBox(height: 18),

            readings.when(
              data: (readings) {
                if (readings.isEmpty) {
                  return const Center(child: Text('No glucose readings yet'));
                }
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: GlucoseWeeklyChart(readings: readings),
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/app_theme.dart';
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

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.secondary.withAlpha(100),
              ),
              child: Icon(
                Icons.trending_up_rounded,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Start Your Health Journey',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Record your first glucose reading to see your health metrics and trends',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade600,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () =>
                    Navigator.pushNamed(context, '/glucose-regist'),
                icon: const Icon(Icons.add_rounded),
                label: const Text('Record First Reading'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentWithReadings(
    BuildContext context,
    List<GlucoseReading> readings,
  ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: CurrentGlucoseCard(
            currentReading: readings.first,
            averageValue: _calculateAverage(readings),
            isTrendingDown: true,
          ),
        ),
        const SizedBox(height: 24),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SelectionCard(
                  icon: Icons.water_drop_outlined,
                  title: 'Check Glucose',
                  subtitle: 'Record new reading',
                  onTap: () => Navigator.pushNamed(context, '/glucose-regist'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SelectionCard(
                  icon: Icons.document_scanner_outlined,
                  title: 'Log Symptoms',
                  subtitle: 'Note how you feel',
                  onTap: () => Navigator.pushNamed(context, '/glucose'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: GlucoseWeeklyChart(readings: readings),
        ),
        const SizedBox(height: 28),
      ],
    );
  }

  Widget _buildGreetingWidget(BuildContext context, String userName) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, $userName 👋',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              'How are you feeling today?',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryMedium),
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          const Icon(
            Icons.error_outline_rounded,
            size: 48,
            color: AppTheme.error,
          ),
          const SizedBox(height: 12),
          Text(error, style: const TextStyle(color: AppTheme.error)),
        ],
      ),
    );
  }

  Widget _buildContentSpace(
    BuildContext context,
    AsyncValue<List<GlucoseReading>> readings,
  ) {
    return readings.when(
      data: (data) {
        if (data.isEmpty) {
          return _buildEmptyState(context);
        }
        return _buildContentWithReadings(context, data);
      },

      loading: () => _buildLoadingState(),

      error: (e, st) => _buildErrorState('Error loading readings'),
    );
  }

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
    final user = ref.watch(userNotifierProvider).user;
    final userName = user!.name;
    final userProfilePic = user.profilePic;

    final readings = ref.watch(glucoseReadingsProvider);

    return Scaffold(
      drawer: DrawerWidget(useName: userName, profilePic: userProfilePic),
      body: Column(
        children: [
          Header(name: userName),
          const SizedBox(height: 24),

          _buildGreetingWidget(context, userName),
          const SizedBox(height: 24),

          Expanded(
            child: SingleChildScrollView(
              child: Center(child: _buildContentSpace(context, readings)),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/app_theme.dart';
import 'package:flutter_app/features/glucose/domain/entities/glucose_reading.dart';
import 'package:flutter_app/features/glucose/presentation/provider/glucose_provider.dart';
import 'package:flutter_app/features/home/prsentation/widgets/drawer.dart';
import 'package:flutter_app/features/home/prsentation/widgets/gluco_chart.dart';
import 'package:flutter_app/features/home/prsentation/widgets/header.dart';
import 'package:flutter_app/features/home/prsentation/widgets/selection_card.dart';
import 'package:flutter_app/features/home/prsentation/widgets/sos_button.dart';
import 'package:flutter_app/features/user/presentation/provider/user_state_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int? _selectedIndex = 0;
  bool _alertShown = false;

  void _emergencyContact() {
    if (_alertShown) return;
    _alertShown = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black54,
      builder: (context) => Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.red.withAlpha(40),
                blurRadius: 20,
                spreadRadius: 0,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.red.shade600, Colors.red.shade400],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(40),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.warning_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Critical Alert',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Low Glucose Detected',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.red.shade200,
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          'Your blood glucose level is critically low and requires immediate attention.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.red.shade700,
                            height: 1.5,
                          ),
                        ),
                      ),
                      SizedBox(height: 24),

                      Text(
                        'What to do now:',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.black,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 12),

                      ...[
                        (
                          'Consume Fast Carbs',
                          'Glucose tablets, juice, or candy',
                        ),
                        ('Recheck in 15 mins', 'Measure your glucose again'),
                        ('Seek Help', 'Contact medical professional'),
                      ].map((item) {
                        int index = [
                          'Consume Fast Carbs',
                          'Recheck in 15 mins',
                          'Seek Help',
                        ].indexOf(item.$1);
                        return Padding(
                          padding: EdgeInsets.only(bottom: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: Colors.red.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                      color: Colors.red.shade700,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.$1,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.black,
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      item.$2,
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),

                      SizedBox(height: 20),

                      Container(
                        padding: EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.orange.shade300,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.emergency_rounded,
                              color: Colors.orange.shade700,
                              size: 20,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'If symptoms worsen, call emergency services (112)',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.orange.shade900,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 24),

                      SosButton(),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 12, left: 24, right: 24),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        _alertShown = false;
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: Colors.grey.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'I understand',
                        style: TextStyle(
                          color: AppTheme.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SelectionCard(
                  icon: Icons.water_drop_outlined,
                  title: 'Regist',
                  onTap: () => Navigator.pushNamed(context, '/glucose-regist'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SelectionCard(
                  icon: Icons.document_scanner_outlined,
                  title: 'Symptoms',
                  onTap: () => Navigator.pushNamed(context, '/symptoms-regist'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SelectionCard(
                  icon: Icons.view_agenda_outlined,
                  title: 'Planner',
                  onTap: () => Navigator.pushNamed(context, '/glucose'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('History', style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(height: 14),
              GlucoseWeeklyChart(readings: readings),
            ],
          ),
        ),
        const SizedBox(height: 28),

        _buildMedicalDisclaimerFooter(),
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
            RichText(
              text: TextSpan(
                text: 'Hi, ',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 20,
                ),
                children: [
                  TextSpan(
                    text: userName,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'How are you feeling today?',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
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

  /*   double _calculateAverage(List<GlucoseReading> readings) {
    if (readings.isEmpty) return 0;

    final sum = readings.fold<double>(
      0,
      (prev, reading) => prev + reading.value,
    );
    return sum / readings.length;
  } */

  Widget _buildMedicalDisclaimerFooter() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 40),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withAlpha(30),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withAlpha(50),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.medical_information_rounded,
              size: 28,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Medical Disclaimer',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This app does not replace professional medical advice, diagnosis, or treatment. Always consult with a qualified healthcare provider regarding your health conditions and treatment plan. GlucoTrack is a monitoring tool only and should be used in conjunction with regular medical check-ups.',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userNotifierProvider).user;
    final userName = user!.name;
    final userProfilePic = user.profilePic;

    final readings = ref.watch(glucoseReadingsProvider);

    readings.whenData((data) {
      if (data.isNotEmpty && data.first.value < 40) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _emergencyContact();
        });
      } else if (data.isNotEmpty && data.first.value >= 70) {
        _alertShown = false;
      }
    });

    return Scaffold(
      drawer: DrawerWidget(useName: userName, profilePic: userProfilePic),
      body: Column(
        children: [
          Header(name: userName),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 11.0),
                    child: _buildGreetingWidget(context, userName),
                  ),
                  const SizedBox(height: 24),
                  Center(child: _buildContentSpace(context, readings)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

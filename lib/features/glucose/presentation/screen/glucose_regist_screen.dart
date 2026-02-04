import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/app_theme.dart';
import 'package:flutter_app/features/glucose/domain/entities/glucose_reading.dart';
import 'package:flutter_app/features/glucose/presentation/provider/glucose_provider.dart';
import 'package:flutter_app/features/glucose/presentation/widgets/glucose_reading_card.dart';
import 'package:flutter_app/features/glucose/presentation/widgets/measurement_card.dart';
import 'package:flutter_app/features/glucose/presentation/widgets/notes_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class GlucoseRegistScreen extends ConsumerStatefulWidget {
  const GlucoseRegistScreen({super.key});

  @override
  ConsumerState<GlucoseRegistScreen> createState() {
    return _GlucoseRegistScreenState();
  }
}

class _GlucoseRegistScreenState extends ConsumerState<GlucoseRegistScreen> {
  late TextEditingController _glucoseRead;
  late TextEditingController _notes;
  String? _selectedType;

  @override
  void initState() {
    super.initState();
    _glucoseRead = TextEditingController();
    _notes = TextEditingController();
  }

  // ---------------------- BUILDS --------------------------

  Widget _buildTitleAppBar() {
    return Row(
      children: [
        Icon(
          Icons.water_drop_outlined,
          color: Theme.of(context).colorScheme.surface,
        ),
        SizedBox(width: 5),
        Text(
          'New Reading',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
      ],
    );
  }

  Widget _buildDateCard() {
    final nowDay = DateTime.now();
    final formattedDay = DateFormat('EEEE, MMMM d, yyyy').format(nowDay);
    final formattedHour = DateFormat('HH:mm').format(nowDay);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(width: 5),
                Text(formattedDay),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Icon(
                  Icons.access_time_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(width: 5),
                Text(formattedHour),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: '💡 Tip: ',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: 'Always measure at the same time for consistent results',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------- FUNCTIONS --------------------------
  bool _canProceed() {
    if (_glucoseRead.text.isNotEmpty && _selectedType != null) {
      return true;
    }
    return false;
  }

  Future<void> _saveReading() async {
    if (!_canProceed()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields'),
          backgroundColor: AppTheme.warning,
        ),
      );
      return;
    }

    try {
      final glucoseNotifier = ref.read(glucoseNotifierProvider.notifier);

      final reading = GlucoseReading(
        id: '',
        value: int.parse(_glucoseRead.text),
        date: DateTime.now(),
        type: _selectedType!,
        notes: _notes.text.isNotEmpty ? _notes.text : null,
      );

      await glucoseNotifier.saveGlucoseReading(reading);

      if (!mounted) return;

      _glucoseRead.clear();
      _notes.clear();
      setState(() => _selectedType = null);
      await ref.refresh(glucoseReadingsProvider.future);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Glucose reading saved successfully!'),
          backgroundColor: AppTheme.success,
        ),
      );

      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: AppTheme.error),
      );
    }
  }

  @override
  void dispose() {
    _glucoseRead.dispose();
    _notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(glucoseNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: Navigator.of(context).pop,
          child: Icon(
            Icons.arrow_back_rounded,
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
        title: _buildTitleAppBar(),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              SizedBox(width: double.infinity, child: _buildDateCard()),

              SizedBox(
                width: double.infinity,
                child: MeasurementCard(
                  selectedType: _selectedType,
                  onTypeSelected: (type) {
                    setState(() {
                      _selectedType = type;
                    });
                  },
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: GlucoseReadingCard(controller: _glucoseRead),
              ),

              SizedBox(
                width: double.infinity,
                child: NotesCard(controller: _notes),
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: state.isLoading ? null : _saveReading,
                  label: Text('Save Glucose Reading'),
                  icon: Icon(Icons.save_outlined),
                ),
              ),

              SizedBox(width: double.infinity, child: _buildFooter()),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/app_theme.dart';
import 'package:flutter_app/features/glucose/presentation/widgets/notes_card.dart';
import 'package:flutter_app/features/symptoms/data/dtos/symptom_dto.dart';
import 'package:flutter_app/features/symptoms/presentation/provider/symptoms_provider.dart';
import 'package:flutter_app/features/symptoms/presentation/widgets/regist_feeling.dart';
import 'package:flutter_app/features/symptoms/presentation/widgets/regist_symptom_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class RegistSymptomsScreen extends ConsumerStatefulWidget {
  const RegistSymptomsScreen({super.key});

  @override
  ConsumerState<RegistSymptomsScreen> createState() {
    return _RegistSymptomsState();
  }
}

class _RegistSymptomsState extends ConsumerState<RegistSymptomsScreen> {
  List<String> _hipoSymptomsSelected = [];
  List<String> _hyperSymptomsSelected = [];
  String? _symptomsSeverity;
  late TextEditingController _notes;

  @override
  void initState() {
    super.initState();
    _notes = TextEditingController();
  }

  @override
  void dispose() {
    _notes.dispose();
    super.dispose();
  }

  // ---------------------- LISTS --------------------------

  final List<Map<String, dynamic>> hipoSymptoms = [
    {'id': 'tremors', 'label': 'Tremors'},
    {'id': 'sweats', 'label': 'Cold Sweats'},
    {'id': 'hunger', 'label': 'Intense Hunger'},
    {'id': 'confusion', 'label': 'Confusion'},
    {'id': 'palpitations', 'label': 'Palpitations'},
    {'id': 'fatigue', 'label': 'Fatigue'},
  ];

  final List<Map<String, dynamic>> hyperSymptoms = [
    {'id': 'thirst', 'label': 'Excessive Thirst'},
    {'id': 'nausea', 'label': 'Nausea'},
    {'id': 'urination', 'label': 'Frequent Urination'},
    {'id': 'blurred', 'label': 'Blurred Vision'},
    {'id': 'headache', 'label': 'Headache'},
    {'id': 'tiredness', 'label': 'Tiredness'},
  ];

  // ---------------------- BUILDS --------------------------

  Widget _buildTitleAppBar() {
    return Row(
      children: [
        Icon(Icons.add_chart, color: Theme.of(context).colorScheme.surface),
        SizedBox(width: 5),
        Text(
          'Log Symptoms',
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

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(40),
            blurRadius: 7,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: Theme.of(context).colorScheme.primary,
                  size: 22,
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
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withAlpha(30),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withAlpha(50),
        ),
        borderRadius: BorderRadius.circular(16),
      ),
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
                text:
                    'Logging symptoms helps you identify patterns and better manage your glucose levels over time. Be honest and detailed!',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------- FUNCTIONS --------------------------
  bool _canContinue() {
    if (_symptomsSeverity != null) {
      return true;
    }
    return false;
  }

  Future<void> saveLog() async {
    final notifier = ref.read(symptomsNotifierProvider.notifier);

    final dto = SymptomsDTO(
      id: '',
      hypoglycemiaSymptoms: _hipoSymptomsSelected,
      hyperglycemiaSymptoms: _hyperSymptomsSelected,
      severity: _symptomsSeverity ?? '',
      timestamp: DateTime.now(),
    );

    try {
      await notifier.createSymptoms(dto.toDomain());
      _successMessage();
      Navigator.pop(context);
    } catch (e) {
      _errorMessage();
      throw Exception('Error saving sympotmns log');
    }
  }

  void _successMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Symptoms saved successfully'),
        backgroundColor: AppTheme.success,
      ),
    );
  }

  void _errorMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Failed to save symptoms. Try again'),
        backgroundColor: AppTheme.error,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: Navigator.of(context).pop,
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
        title: _buildTitleAppBar(),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Column(
            children: [
              SizedBox(width: double.infinity, child: _buildDateCard()),
              SizedBox(height: 18),

              RegistSymptomCard(
                icon: Icons.arrow_circle_down_rounded,
                title: 'Hypoglycemia Symptoms',
                subtitle: 'Low blood sugar (<70 mg/dL)',
                symptoms: hipoSymptoms,
                onTypesSelected: (List<String> values) {
                  setState(() {
                    _hipoSymptomsSelected = values;
                  });
                },
                selectedTypes: _hipoSymptomsSelected,
              ),
              const SizedBox(height: 18),
              RegistSymptomCard(
                icon: Icons.arrow_circle_up_rounded,
                title: 'Hyperglycemia Symptoms',
                subtitle: 'High blood sugar (>140 mg/dL)',
                symptoms: hyperSymptoms,
                onTypesSelected: (List<String> values) {
                  setState(() {
                    _hyperSymptomsSelected = values;
                  });
                },
                selectedTypes: _hyperSymptomsSelected,
              ),
              SizedBox(height: 18),
              RegistFeelingCard(
                selectedType: _symptomsSeverity,
                onTypeSelected: (value) {
                  setState(() {
                    _symptomsSeverity = value;
                  });
                },
              ),
              SizedBox(height: 18),
              NotesCard(controller: _notes),
              SizedBox(height: 18),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _canContinue() ? saveLog : null,
                  label: Text('Save Sympotms Report '),
                  icon: Icon(Icons.save_outlined),
                ),
              ),
              SizedBox(height: 18),
              SizedBox(width: double.infinity, child: _buildFooter()),
            ],
          ),
        ),
      ),
    );
  }
}

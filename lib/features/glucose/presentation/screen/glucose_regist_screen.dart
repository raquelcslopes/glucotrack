import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/app_theme.dart';
import 'package:flutter_app/features/glucose/presentation/widgets/glucose_reading_card.dart';
import 'package:flutter_app/features/glucose/presentation/widgets/measurement_card.dart';
import 'package:intl/intl.dart';

class GlucoseRegistScreen extends StatefulWidget {
  const GlucoseRegistScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _GlucoseRegistScreenState();
  }
}

class _GlucoseRegistScreenState extends State<GlucoseRegistScreen> {
  late TextEditingController _glucoseRead;
  String? _selectedType;

  @override
  void initState() {
    super.initState();

    _glucoseRead = TextEditingController();
  }

  Widget _buildTitleAppBar() {
    return Row(
      children: [
        Icon(Icons.water_drop_outlined, color: Colors.white),
        SizedBox(width: 5),
        Text('New Reading'),
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
                  color: AppTheme.primaryMedium,
                ),
                SizedBox(width: 5),
                Text(formattedDay),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Icon(Icons.access_time_rounded),
                SizedBox(width: 5),
                Text(formattedHour),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _glucoseRead;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: Navigator.of(context).pop,
          child: Icon(Icons.arrow_back_rounded),
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
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app/features/planner/presentation/widgets/appointment_type.dart';
import 'package:flutter_app/features/planner/presentation/widgets/date_card.dart';
import 'package:flutter_app/features/planner/presentation/widgets/doctor_info.dart';
import 'package:flutter_app/features/planner/presentation/widgets/local_info.dart';

class NewAppointmentScreen extends StatefulWidget {
  const NewAppointmentScreen({super.key});

  @override
  State<NewAppointmentScreen> createState() => _NewAppointmentScreenState();
}

class _NewAppointmentScreenState extends State<NewAppointmentScreen> {
  String? _appointmentType;
  late TextEditingController _doctorName;
  DateTime? _date;
  TimeOfDay? _time;
  late TextEditingController _hospital;
  late TextEditingController _adress;

  @override
  void initState() {
    super.initState();
    _doctorName = TextEditingController();
    _hospital = TextEditingController();
    _adress = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
        title: const Text('New Appointment'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: AppointmentTypeCard(
                onSelected: (String value) {
                  setState(() {
                    _appointmentType = value;
                  });
                },
                selectedType: _appointmentType ?? '',
              ),
            ),
            SizedBox(height: 18),

            SizedBox(
              width: double.infinity,
              child: DoctorInfo(controller: _doctorName),
            ),
            SizedBox(height: 18),

            SizedBox(
              width: double.infinity,
              child: DateCard(
                selectedDate: _date,
                time: _time,
                onDateChanged: (DateTime? date) {
                  setState(() {
                    _date = date;
                  });
                },
                onTimeChanged: (TimeOfDay? time) {
                  setState(() {
                    _time = time;
                  });
                },
              ),
            ),
            SizedBox(height: 18),

            SizedBox(
              width: double.infinity,
              child: LocalInfoCard(
                localController: _hospital,
                adressController: _adress,
              ),
            ),
            SizedBox(height: 18),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  label: Text('Create Appointment'),
                  icon: Icon(Icons.check),
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 16),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _doctorName.dispose();
    _hospital.dispose();
    _adress.dispose();
    super.dispose();
  }
}

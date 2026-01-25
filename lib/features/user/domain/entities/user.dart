import 'package:flutter_app/features/user/domain/entities/insulin_schedule.dart';

class User {
  final String firstName;
  final String lastName;
  final int height;
  final double weight;
  final double imc;
  final bool takesInsulin;
  final List<InsulinSchedule>? insulinScheme;

  User({
    required this.firstName,
    required this.lastName,
    required this.height,
    required this.weight,
    required this.imc,
    required this.takesInsulin,
    this.insulinScheme,
  });
}

import 'package:flutter_app/features/planner/domain/entities/appointment.dart';

abstract class PlannerRepositoryInterface {
  Future<List<Appointment>> getAppointments();
  Future<void> createAppointment(Appointment appointment);
}

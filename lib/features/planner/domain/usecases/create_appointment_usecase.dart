import 'package:flutter_app/features/planner/domain/entities/appointment.dart';
import 'package:flutter_app/features/planner/domain/repositories/planner_repository_interface.dart';

class CreateAppointmentUsecase {
  final PlannerRepositoryInterface repository;

  const CreateAppointmentUsecase(this.repository);

  Future<void> createAppointment(Appointment appointment) async {
    await repository.createAppointment(appointment);
  }
}

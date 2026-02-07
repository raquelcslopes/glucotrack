import 'package:flutter_app/features/planner/domain/entities/appointment.dart';
import 'package:flutter_app/features/planner/domain/repositories/planner_repository_interface.dart';

class GetAppointmentsUsecase {
  final PlannerRepositoryInterface repository;

  const GetAppointmentsUsecase(this.repository);

  Future<List<Appointment>> getAppointments() async {
    final response = await repository.getAppointments();
    return response;
  }
}

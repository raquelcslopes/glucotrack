import 'package:flutter_app/features/planner/domain/entities/appointment.dart';

class PlannerState {
  final List<Appointment> appointments;
  final bool isLoading;
  final String? errorMessage;

  const PlannerState({
    required this.appointments,
    this.isLoading = false,
    this.errorMessage,
  });

  PlannerState copyWith({
    List<Appointment>? appointments,
    bool? isLoading,
    String? errorMessage,
  }) {
    return PlannerState(
      appointments: appointments ?? this.appointments,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  PlannerState clearError() {
    return PlannerState(
      appointments: appointments,
      isLoading: isLoading,
      errorMessage: null,
    );
  }
}

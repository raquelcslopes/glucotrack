import 'package:flutter_app/features/planner/domain/usecases/get_appointments_usecase.dart';
import 'package:flutter_app/features/planner/presentation/state/planner_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlannerStateNotifier extends StateNotifier<PlannerState> {
  final GetAppointmentsUsecase usecase;

  PlannerStateNotifier(this.usecase)
    : super(const PlannerState(appointments: []));

  Future<void> getAppointments() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final response = await usecase.getAppointments();
      state = state.copyWith(
        isLoading: false,
        appointments: response,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

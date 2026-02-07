import 'package:flutter_app/features/symptoms/domain/entities/symptoms.dart';
import 'package:flutter_app/features/symptoms/domain/usecases/create_symptom.dart';
import 'package:flutter_app/features/symptoms/presentation/state/symptom_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SymptomsStateNotifier extends StateNotifier<SymptomsState> {
  final CreateSymptomUseCase usecase;

  SymptomsStateNotifier(this.usecase)
    : super(const SymptomsState(symptoms: []));

  Future<void> createSymptoms(Symptoms symptom) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await usecase.createSymptomUseCase(symptom);
      state = state.copyWith(
        isLoading: false,
        symptoms: [...state.symptoms, symptom],
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

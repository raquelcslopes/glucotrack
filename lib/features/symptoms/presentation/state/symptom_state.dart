import 'package:flutter_app/features/symptoms/domain/entities/symptoms.dart';

class SymptomsState {
  final List<Symptoms> symptoms;
  final bool isLoading;
  final String? errorMessage;

  const SymptomsState({
    required this.symptoms,
    this.isLoading = false,
    this.errorMessage,
  });

  SymptomsState copyWith({
    List<Symptoms>? symptoms,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SymptomsState(
      symptoms: symptoms ?? this.symptoms,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  SymptomsState clearError() {
    return SymptomsState(
      symptoms: symptoms,
      isLoading: isLoading,
      errorMessage: null,
    );
  }
}

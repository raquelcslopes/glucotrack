import 'package:flutter_app/features/glucose/domain/entities/glucose_reading.dart';

class GlucoseState {
  final GlucoseReading? reading;
  final bool isLoading;
  final String? errorMessage;

  const GlucoseState({this.reading, this.isLoading = false, this.errorMessage});

  GlucoseState copyWith({
    GlucoseReading? reading,
    bool? isLoading,
    String? errorMessage,
  }) {
    return GlucoseState(
      reading: reading ?? this.reading,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  GlucoseState clearError() {
    return GlucoseState(
      reading: reading,
      isLoading: isLoading,
      errorMessage: null,
    );
  }
}

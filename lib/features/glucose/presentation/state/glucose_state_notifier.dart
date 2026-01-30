import 'package:flutter_app/features/glucose/domain/entities/glucose_reading.dart';
import 'package:flutter_app/features/glucose/domain/usecases/save_reading_usecase.dart';
import 'package:flutter_app/features/glucose/presentation/state/glucose_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GlucoseStateNotifier extends StateNotifier<GlucoseState> {
  final SaveReadingUsecase usecase;

  GlucoseStateNotifier(this.usecase) : super(const GlucoseState());

  Future<void> saveGlucoseReading(GlucoseReading reading) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await usecase.saveGlucoseReadingUseCase(reading);
      state = state.copyWith(
        isLoading: false,
        reading: reading,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

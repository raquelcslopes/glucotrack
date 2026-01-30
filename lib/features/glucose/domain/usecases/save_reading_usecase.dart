import 'package:flutter_app/features/glucose/domain/entities/glucose_reading.dart';
import 'package:flutter_app/features/glucose/domain/repositories/glucose_repository_interface.dart';

class SaveReadingUsecase {
  final GlucoseRepositoryInterface repository;

  const SaveReadingUsecase(this.repository);

  Future<void> saveGlucoseReadingUseCase(GlucoseReading reading) async {
    await repository.saveGlucoseReading(reading);
  }
}

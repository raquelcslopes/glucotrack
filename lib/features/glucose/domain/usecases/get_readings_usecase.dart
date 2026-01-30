import 'package:flutter_app/features/glucose/domain/entities/glucose_reading.dart';
import 'package:flutter_app/features/glucose/domain/repositories/glucose_repository_interface.dart';

class GetReadingsUsecase {
  final GlucoseRepositoryInterface repository;

  const GetReadingsUsecase(this.repository);

  Future<List<GlucoseReading>> getGlucoseReadings() async {
    final response = await repository.getGlucoseReadings();

    return response;
  }
}

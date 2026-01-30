import 'package:flutter_app/features/glucose/domain/entities/glucose_reading.dart';

abstract class GlucoseRepositoryInterface {
  Future<void> saveGlucoseReading(GlucoseReading reading);
  Future<List<GlucoseReading>> getGlucoseReadings();
}

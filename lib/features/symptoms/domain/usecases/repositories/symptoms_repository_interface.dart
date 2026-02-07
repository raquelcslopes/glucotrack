import 'package:flutter_app/features/symptoms/domain/entities/symptoms.dart';

abstract class SymptomsInterface {
  Future<void> createSymptom(Symptoms symptom);
}

import 'package:flutter_app/features/symptoms/domain/entities/symptoms.dart';
import 'package:flutter_app/features/symptoms/domain/repositories/symptoms_repository_interface.dart';

class CreateSymptomUseCase {
  final SymptomsInterface repository;

  const CreateSymptomUseCase(this.repository);

  Future<void> createSymptomUseCase(Symptoms symptom) async {
    await repository.createSymptom(symptom);
  }
}

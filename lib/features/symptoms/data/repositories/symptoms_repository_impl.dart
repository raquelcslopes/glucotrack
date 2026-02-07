import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/features/symptoms/data/dtos/symptom_dto.dart';
import 'package:flutter_app/features/symptoms/domain/entities/symptoms.dart';
import 'package:flutter_app/features/symptoms/domain/repositories/symptoms_repository_interface.dart';

class SymptomsRepositoryImpl implements SymptomsInterface {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  SymptomsRepositoryImpl({required this.firestore, required this.auth});

  final String _userCollection = 'users';
  final String _symptomsCollection = 'symptoms';
  String get _userId => auth.currentUser?.uid ?? '';

  @override
  Future<void> createSymptom(Symptoms symptom) async {
    final dto = SymptomsDTO.fromDomain(symptom);

    try {
      await firestore
          .collection(_userCollection)
          .doc(_userId)
          .collection(_symptomsCollection)
          .add(dto.toMap());
    } catch (e) {
      throw Exception('Error saving symptoms');
    }
  }
}

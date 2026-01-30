import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/features/glucose/data/dto/glucose_reading_dto.dart';
import 'package:flutter_app/features/glucose/domain/entities/glucose_reading.dart';
import 'package:flutter_app/features/glucose/domain/repositories/glucose_repository_interface.dart';

class GlucoseRepositoryImpl implements GlucoseRepositoryInterface {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  GlucoseRepositoryImpl({required this.firestore, required this.auth});

  final String _userCollection = 'users';
  final String _glucoseCollection = 'glucose_readings';
  String get _userId => auth.currentUser?.uid ?? '';

  @override
  Future<void> saveGlucoseReading(GlucoseReading reading) async {
    final dto = GlucoseReadingDto.fromEntity(reading);
    try {
      await firestore
          .collection(_userCollection)
          .doc(_userId)
          .collection(_glucoseCollection)
          .add(dto.toMap());
    } catch (e) {
      throw Exception('Error saving glucose record: $e');
    }
  }

  @override
  Future<List<GlucoseReading>> getGlucoseReadings() async {
    try {
      final response = await firestore
          .collection(_userCollection)
          .doc(_userId)
          .collection(_glucoseCollection)
          .orderBy('date', descending: true)
          .get();

      return response.docs.map((doc) {
        final data = doc.data();
        return GlucoseReadingDto.fromMap({
          ...data,
          'id': doc.id,
        }).toEntity(id: doc.id);
      }).toList();
    } catch (e) {
      throw Exception('Error fetching readings: $e');
    }
  }
}

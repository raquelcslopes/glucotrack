import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/features/planner/domain/entities/appointment.dart';
import 'package:flutter_app/features/planner/domain/repositories/planner_repository_interface.dart';

class PlannerRepositoryImpl implements PlannerRepositoryInterface {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  PlannerRepositoryImpl({required this.auth, required this.firestore});

  final String _userCollection = 'users';
  final String _appointmentsCollection = 'appointments';
  String get _userId => auth.currentUser?.uid ?? '';

  @override
  Future<void> createAppointment(Appointment appointment) {
    // TODO: implement createAppointment
    throw UnimplementedError();
  }

  @override
  Future<List<Appointment>> getAppointments() async {
    try {
      final response = await firestore
          .collection(_userCollection)
          .doc(_userId)
          .collection(_appointmentsCollection)
          .orderBy('date', descending: true)
          .get();

      if (response.docs.isEmpty) return [];

      return response.docs
          .map((doc) => Appointment.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Error loading planner');
    }
  }
}

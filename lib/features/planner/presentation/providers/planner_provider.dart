import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/features/planner/data/repositories/planner_repository_impl.dart';
import 'package:flutter_app/features/planner/domain/repositories/planner_repository_interface.dart';
import 'package:flutter_app/features/planner/domain/usecases/get_appointments_usecase.dart';
import 'package:flutter_app/features/planner/presentation/state/planner_state.dart';
import 'package:flutter_app/features/planner/presentation/state/planner_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseFirestoreProvider = Provider((ref) => FirebaseFirestore.instance);
final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);

final plannerRepositoryProvider = Provider<PlannerRepositoryInterface>((ref) {
  return PlannerRepositoryImpl(
    firestore: ref.watch(firebaseFirestoreProvider),
    auth: ref.watch(firebaseAuthProvider),
  );
});

final getAppointmentsUsecaseProvider = Provider((ref) {
  final repository = ref.watch(plannerRepositoryProvider);
  return GetAppointmentsUsecase(repository);
});

final plannerNotifierProvider =
    StateNotifierProvider<PlannerStateNotifier, PlannerState>((ref) {
      final getAppoitmentsUseCase = ref.watch(getAppointmentsUsecaseProvider);
      return PlannerStateNotifier(getAppoitmentsUseCase);
    });

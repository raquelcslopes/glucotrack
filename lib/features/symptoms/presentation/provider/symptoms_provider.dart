import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/features/symptoms/data/repositories/symptoms_repository_impl.dart';
import 'package:flutter_app/features/symptoms/domain/usecases/create_symptom.dart';
import 'package:flutter_app/features/symptoms/domain/usecases/repositories/symptoms_repository_interface.dart';
import 'package:flutter_app/features/symptoms/presentation/state/symptom_state.dart';
import 'package:flutter_app/features/symptoms/presentation/state/symptoms_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseFirestoreProvider = Provider((ref) => FirebaseFirestore.instance);
final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);

final symptomsRepositoryProvider = Provider<SymptomsInterface>((ref) {
  return SymptomsRepositoryImpl(
    firestore: ref.watch(firebaseFirestoreProvider),
    auth: ref.watch(firebaseAuthProvider),
  );
});

final createSymptomsUsecaseProvider = Provider((ref) {
  final repository = ref.watch(symptomsRepositoryProvider);
  return CreateSymptomUseCase(repository);
});

final symptomsNotifierProvider =
    StateNotifierProvider<SymptomsStateNotifier, SymptomsState>((ref) {
      final createSymptomsUseCase = ref.watch(createSymptomsUsecaseProvider);
      return SymptomsStateNotifier(createSymptomsUseCase);
    });

/* final symptomsProvider = FutureProvider<void>((ref) async {
  final repository = ref.watch(symptomsRepositoryProvider);
  return repository.createSymptom();
}); */

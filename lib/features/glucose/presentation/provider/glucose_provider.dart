import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/features/glucose/data/repositories/glucose_repository_impl.dart';
import 'package:flutter_app/features/glucose/domain/entities/glucose_reading.dart';
import 'package:flutter_app/features/glucose/domain/repositories/glucose_repository_interface.dart';
import 'package:flutter_app/features/glucose/domain/usecases/save_reading_usecase.dart';
import 'package:flutter_app/features/glucose/presentation/state/glucose_state.dart';
import 'package:flutter_app/features/glucose/presentation/state/glucose_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseFirestoreProvider = Provider((ref) => FirebaseFirestore.instance);
final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);

final glucoseRepositoryProvider = Provider<GlucoseRepositoryInterface>((ref) {
  return GlucoseRepositoryImpl(
    firestore: ref.watch(firebaseFirestoreProvider),
    auth: ref.watch(firebaseAuthProvider),
  );
});

final saveReadingUsecaseProvider = Provider((ref) {
  final repository = ref.watch(glucoseRepositoryProvider);
  return SaveReadingUsecase(repository);
});

final glucoseNotifierProvider =
    StateNotifierProvider<GlucoseStateNotifier, GlucoseState>((ref) {
      final saveReadingUsecase = ref.watch(saveReadingUsecaseProvider);
      return GlucoseStateNotifier(saveReadingUsecase);
    });

final glucoseReadingsProvider = FutureProvider<List<GlucoseReading>>((
  ref,
) async {
  final repository = ref.watch(glucoseRepositoryProvider);
  return repository.getGlucoseReadings();
});

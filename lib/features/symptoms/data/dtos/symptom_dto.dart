import 'package:flutter_app/features/symptoms/domain/entities/symptoms.dart';

class SymptomsDTO {
  final String id;
  final List<String> hypoglycemiaSymptoms;
  final List<String> hyperglycemiaSymptoms;
  final String severity;
  final String? notes;
  final DateTime timestamp;

  SymptomsDTO({
    required this.id,
    required this.hypoglycemiaSymptoms,
    required this.hyperglycemiaSymptoms,
    required this.severity,
    this.notes,
    required this.timestamp,
  });

  Symptoms toDomain() {
    return Symptoms(
      id: id,
      hypoglycemiaSymptoms: hypoglycemiaSymptoms,
      hyperglycemiaSymptoms: hyperglycemiaSymptoms,
      severity: severity,
      notes: notes,
      timestamp: timestamp,
    );
  }

  factory SymptomsDTO.fromDomain(Symptoms symptoms) {
    return SymptomsDTO(
      id: symptoms.id,
      hypoglycemiaSymptoms: symptoms.hypoglycemiaSymptoms,
      hyperglycemiaSymptoms: symptoms.hyperglycemiaSymptoms,
      severity: symptoms.severity,
      notes: symptoms.notes,
      timestamp: symptoms.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'hypoglycemiaSymptoms': hypoglycemiaSymptoms,
      'hyperglycemiaSymptoms': hyperglycemiaSymptoms,
      'severity': severity,
      'notes': notes,
      'timestamp': timestamp.toIso8601String(),
      'createdAt': DateTime.now().toIso8601String(),
    };
  }

  factory SymptomsDTO.fromMap(Map<String, dynamic> json) {
    return SymptomsDTO(
      id: json['id'] as String? ?? '',
      hypoglycemiaSymptoms: List<String>.from(
        json['hypoglycemiaSymptoms'] ?? [],
      ),
      hyperglycemiaSymptoms: List<String>.from(
        json['hyperglycemiaSymptoms'] ?? [],
      ),
      severity: json['severity'] as String? ?? 'mild',
      notes: json['notes'] as String?,
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'] as String)
          : DateTime.now(),
    );
  }

  SymptomsDTO copyWith({
    String? id,
    List<String>? hypoglycemiaSymptoms,
    List<String>? hyperglycemiaSymptoms,
    String? severity,
    String? notes,
    DateTime? timestamp,
  }) {
    return SymptomsDTO(
      id: id ?? this.id,
      hypoglycemiaSymptoms: hypoglycemiaSymptoms ?? this.hypoglycemiaSymptoms,
      hyperglycemiaSymptoms:
          hyperglycemiaSymptoms ?? this.hyperglycemiaSymptoms,
      severity: severity ?? this.severity,
      notes: notes ?? this.notes,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  List<Object?> get props => [
    id,
    hypoglycemiaSymptoms,
    hyperglycemiaSymptoms,
    severity,
    notes,
    timestamp,
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SymptomsDTO &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          hypoglycemiaSymptoms == other.hypoglycemiaSymptoms &&
          hyperglycemiaSymptoms == other.hyperglycemiaSymptoms &&
          severity == other.severity &&
          notes == other.notes &&
          timestamp == other.timestamp;

  @override
  int get hashCode =>
      id.hashCode ^
      hypoglycemiaSymptoms.hashCode ^
      hyperglycemiaSymptoms.hashCode ^
      severity.hashCode ^
      notes.hashCode ^
      timestamp.hashCode;

  @override
  String toString() {
    return 'SymptomsDTO(id: $id, hypo: ${hypoglycemiaSymptoms.length}, hyper: ${hyperglycemiaSymptoms.length}, severity: $severity, timestamp: $timestamp, notes: $notes)';
  }
}

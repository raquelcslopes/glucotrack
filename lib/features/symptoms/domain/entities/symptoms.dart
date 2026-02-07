class Symptoms {
  final String id;
  final List<String> hypoglycemiaSymptoms;
  final List<String> hyperglycemiaSymptoms;
  final String severity;
  final String? notes;
  final DateTime timestamp;

  Symptoms({
    required this.id,
    required this.hypoglycemiaSymptoms,
    required this.hyperglycemiaSymptoms,
    required this.severity,
    this.notes,
    required this.timestamp,
  });

  Symptoms copyWith({
    String? id,
    List<String>? hypoglycemiaSymptoms,
    List<String>? hyperglycemiaSymptoms,
    String? severity,
    String? notes,
    DateTime? timestamp,
  }) {
    return Symptoms(
      id: id ?? this.id,
      hypoglycemiaSymptoms: hypoglycemiaSymptoms ?? this.hypoglycemiaSymptoms,
      hyperglycemiaSymptoms:
          hyperglycemiaSymptoms ?? this.hyperglycemiaSymptoms,
      severity: severity ?? this.severity,
      notes: notes ?? this.notes,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Symptoms &&
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
    return 'Symptoms(id: $id, hypo: ${hypoglycemiaSymptoms.length}, hyper: ${hyperglycemiaSymptoms.length}, severity: $severity, timestamp: $timestamp)';
  }
}

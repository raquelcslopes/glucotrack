class GlucoseReading {
  final String id;
  final int value;
  final DateTime date;
  final String type;
  final String? notes;

  GlucoseReading({
    required this.id,
    required this.value,
    required this.date,
    required this.type,
    this.notes,
  });

  GlucoseReading copyWith({
    String? id,
    int? value,
    DateTime? date,
    String? type,
    String? notes,
  }) {
    return GlucoseReading(
      id: id ?? this.id,
      value: value ?? this.value,
      date: date ?? this.date,
      type: type ?? this.type,
      notes: notes ?? this.notes,
    );
  }

  List<Object?> get props => [id, value, date, type, notes];

  @override
  String toString() {
    return 'User(id: $id, value: ${value}mg/dl, date: $date, type: $type, notes: $notes)';
  }
}

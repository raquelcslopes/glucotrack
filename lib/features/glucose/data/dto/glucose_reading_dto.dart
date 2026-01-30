import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/features/glucose/domain/entities/glucose_reading.dart';

class GlucoseReadingDto {
  final int value;
  final DateTime date;
  final String type;
  final String? notes;

  GlucoseReadingDto({
    required this.value,
    required this.date,
    required this.type,
    this.notes,
  });

  factory GlucoseReadingDto.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return GlucoseReadingDto(
      value: data['value'] as int,
      date: (data['date'] as Timestamp).toDate(),
      type: data['type'] as String,
      notes: data['notes'] as String?,
    );
  }

  factory GlucoseReadingDto.fromMap(Map<String, dynamic> map) {
    return GlucoseReadingDto(
      value: map['value'] as int,
      date: map['date'] is DateTime
          ? map['date'] as DateTime
          : (map['date'] as Timestamp).toDate(),
      type: map['type'] as String,
      notes: map['notes'] as String?,
    );
  }

  factory GlucoseReadingDto.fromJson(String source) {
    return GlucoseReadingDto.fromMap(
      json.decode(source) as Map<String, dynamic>,
    );
  }

  factory GlucoseReadingDto.fromEntity(GlucoseReading entity) {
    return GlucoseReadingDto(
      value: entity.value,
      date: entity.date,
      type: entity.type,
      notes: entity.notes,
    );
  }

  GlucoseReading toEntity({required String id}) {
    return GlucoseReading(
      id: id,
      value: value,
      date: date,
      type: type,
      notes: notes,
    );
  }

  Map<String, dynamic> toMap() {
    return {'value': value, 'date': date, 'type': type, 'notes': notes};
  }

  String toJson() => json.encode(toMap());

  GlucoseReadingDto copyWith({
    int? value,
    DateTime? date,
    String? type,
    String? notes,
  }) {
    return GlucoseReadingDto(
      value: value ?? this.value,
      date: date ?? this.date,
      type: type ?? this.type,
      notes: notes ?? this.notes,
    );
  }

  @override
  String toString() {
    return 'GlucoseReadingDto(value: $value, date: $date, type: $type, notes: $notes)';
  }
}

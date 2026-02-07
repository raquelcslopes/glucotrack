import 'package:flutter_app/features/planner/domain/entities/appointment.dart';

class AppointmentDto {
  final String id;
  final String type;
  final String doctor;
  final String specialty;
  final String date;
  final String time;
  final String location;
  final String address;
  final String status;

  AppointmentDto({
    required this.id,
    required this.type,
    required this.doctor,
    required this.specialty,
    required this.date,
    required this.time,
    required this.location,
    required this.address,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'doctor': doctor,
      'specialty': specialty,
      'date': date,
      'time': time,
      'location': location,
      'address': address,
      'status': status,
    };
  }

  factory AppointmentDto.fromJson(Map<String, dynamic> json) {
    return AppointmentDto(
      id: json['id'] as String,
      type: json['type'] as String,
      doctor: json['doctor'] as String,
      specialty: json['specialty'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
      location: json['location'] as String,
      address: json['address'] as String,
      status: json['status'] as String,
    );
  }

  Appointment toEntity() {
    return Appointment(
      id: id,
      type: type,
      doctorName: doctor,
      specialty: specialty,
      date: DateTime.parse(date),
      time: time,
      location: location,
      address: address,
      status: status,
    );
  }

  factory AppointmentDto.fromEntity(Appointment entity) {
    return AppointmentDto(
      id: entity.id,
      type: entity.type,
      doctor: entity.doctorName,
      specialty: entity.specialty,
      date: entity.date.toIso8601String(),
      time: entity.time,
      location: entity.location,
      address: entity.address,
      status: entity.status,
    );
  }

  @override
  String toString() {
    return 'AppointmentDto(id: $id, type: $type, doctor: $doctor, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppointmentDto &&
        other.id == id &&
        other.type == type &&
        other.doctor == doctor &&
        other.specialty == specialty &&
        other.date == date &&
        other.time == time &&
        other.location == location &&
        other.address == address &&
        other.status == status;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      type,
      doctor,
      specialty,
      date,
      time,
      location,
      address,
      status,
    );
  }
}

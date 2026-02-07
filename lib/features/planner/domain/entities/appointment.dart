class Appointment {
  final String id;
  final String type;
  final String doctorName;
  final String specialty;
  final DateTime date;
  final String time;
  final String location;
  final String address;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Appointment({
    required this.id,
    required this.type,
    required this.doctorName,
    required this.specialty,
    required this.date,
    required this.time,
    required this.location,
    required this.address,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'doctorName': doctorName,
      'specialty': specialty,
      'date': date.toIso8601String(),
      'time': time,
      'location': location,
      'address': address,
      'status': status,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      id: map['id'] as String,
      type: map['type'] as String,
      doctorName: map['doctorName'] as String,
      specialty: map['specialty'] as String,
      date: DateTime.parse(map['date'] as String),
      time: map['time'] as String,
      location: map['location'] as String,
      address: map['address'] as String,
      status: map['status'] as String,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'] as String)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'] as String)
          : null,
    );
  }

  Appointment copyWith({
    String? id,
    String? type,
    String? doctorName,
    String? specialty,
    DateTime? date,
    String? time,
    String? location,
    String? address,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Appointment(
      id: id ?? this.id,
      type: type ?? this.type,
      doctorName: doctorName ?? this.doctorName,
      specialty: specialty ?? this.specialty,
      date: date ?? this.date,
      time: time ?? this.time,
      location: location ?? this.location,
      address: address ?? this.address,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'AppointmentEntity(id: $id, type: $type, doctor: $doctorName, date: $date, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Appointment &&
        other.id == id &&
        other.type == type &&
        other.doctorName == doctorName &&
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
      doctorName,
      specialty,
      date,
      time,
      location,
      address,
      status,
    );
  }
}

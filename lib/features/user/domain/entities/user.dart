import 'package:flutter_app/features/user/domain/entities/insulin_schedule.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String? profilePic;
  final int height;
  final double weight;
  final double imc;
  final bool takesInsulin;
  final List<InsulinSchedule>? insulinScheme;
  final bool isCompelete;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.profilePic,
    required this.height,
    required this.weight,
    required this.imc,
    required this.takesInsulin,
    this.insulinScheme,
    required this.isCompelete,
  });

  User copyWith({
    String? userId,
    String? name,
    String? email,
    String? profilePic,
    int? height,
    double? weight,
    bool? takesInsulin,
    double? imc,
    bool? isCompelete,
  }) {
    return User(
      id: userId ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profilePic: profilePic ?? this.profilePic,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      takesInsulin: takesInsulin ?? this.takesInsulin,
      imc: imc ?? this.imc,
      isCompelete: isCompelete ?? this.isCompelete,
    );
  }

  List<Object?> get props => [
    id,
    name,
    email,
    profilePic,
    height,
    weight,
    takesInsulin,
  ];

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, height: ${height}cm, weight: ${weight}kg, imc: ${imc.toStringAsFixed(1)}, takesInsulin: $takesInsulin)';
  }
}

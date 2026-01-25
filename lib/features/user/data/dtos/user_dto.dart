import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/features/user/domain/entities/insulin_schedule.dart';
import 'package:flutter_app/features/user/domain/entities/user.dart';

class UserDto {
  final String userId;
  final String name;
  final String? profilePic;
  final int height;
  final double weight;
  final double imc;
  final bool takesInsulin;
  final List<InsulinSchedule>? insulinScheme;

  UserDto({
    required this.userId,
    required this.name,
    this.profilePic,
    required this.height,
    required this.weight,
    required this.imc,
    required this.takesInsulin,
    this.insulinScheme,
  });

  factory UserDto.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return UserDto(
      userId: doc.id,
      name: data['name'] as String,
      profilePic: data['profile_pic'] as String?,
      height: (data['height'] as num).toInt(),
      weight: (data['weight'] as num).toDouble(),
      imc: (data['imc'] as num).toDouble(),
      takesInsulin: data['takes_insulin'] as bool,
    );
  }

  factory UserDto.fromMap(Map<String, dynamic> map) {
    return UserDto(
      userId: map['user_id'] as String,
      name: map['name'] as String,
      profilePic: map['profile_pic'] as String?,
      height: (map['height'] as num).toInt(),
      weight: (map['weight'] as num).toDouble(),
      imc: (map['imc'] as num).toDouble(),
      takesInsulin: map['takes_insulin'] as bool,
    );
  }

  factory UserDto.fromJson(String source) {
    return UserDto.fromMap(json.decode(source) as Map<String, dynamic>);
  }

  factory UserDto.fromEntity(User entity) {
    return UserDto(
      userId: entity.id,
      name: entity.name,
      profilePic: entity.profilePic,
      height: entity.height,
      weight: entity.weight,
      imc: entity.imc,
      takesInsulin: entity.takesInsulin,
      insulinScheme: entity.insulinScheme,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'name': name,
      'profile_pic': profilePic,
      'height': height,
      'weight': weight,
      'imc': imc,
      'takes_insulin': takesInsulin,
    };
  }

  String toJson() => json.encode(toMap());

  UserDto copyWith({
    String? userId,
    String? name,
    String? profilePic,
    int? height,
    double? weight,
    double? imc,
    bool? takesInsulin,
    List<InsulinSchedule>? insulinScheme,
  }) {
    return UserDto(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      imc: imc ?? this.imc,
      takesInsulin: takesInsulin ?? this.takesInsulin,
      insulinScheme: insulinScheme ?? this.insulinScheme,
    );
  }

  @override
  String toString() {
    return 'UserDto(userId: $userId, name: $name, height: $height, weight: $weight, imc: ${imc.toStringAsFixed(1)}, takesInsulin: $takesInsulin)';
  }
}

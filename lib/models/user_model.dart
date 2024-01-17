import 'package:flutter/foundation.dart';
import 'package:yeko_pointage/core/core.dart';

@immutable
class UserModel {
  const UserModel({
    this.id = '',
    this.email = '',
    this.username = '',
    this.schoolId,
  });

  factory UserModel.fromJson({required Mapper<dynamic> json}) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      schoolId: json['school_id'] as String?,
    );
  }

  final String id;
  final String email;
  final String username;
  final String? schoolId;

  Mapper<dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'school_id': schoolId,
      'updated_at': DateTime.now().toIso8601String(),
    };
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? username,
    String? schoolId,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      schoolId: schoolId ?? this.schoolId,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, username: $username, schoolId: $schoolId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.email == email &&
        other.username == username &&
        other.schoolId == schoolId;
  }

  @override
  int get hashCode {
    return id.hashCode ^ email.hashCode ^ username.hashCode ^ schoolId.hashCode;
  }
}

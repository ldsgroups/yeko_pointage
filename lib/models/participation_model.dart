import 'package:flutter/foundation.dart';
import 'package:yeko_pointage/core/core.dart';

@immutable
class ParticipationModel {
  const ParticipationModel({
    this.id = '',
    required this.studentId,
    required this.subjectId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ParticipationModel.fromJson({required Mapper<dynamic> json}) {
    return ParticipationModel(
      id: json['id'] == null ? '' : json['id'] as String,
      studentId: json['student_id'] as String,
      subjectId: json['subject_id'] as String,
      createdAt: json['created_at'] == null
          ? DateTime.now()
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(json['updated_at'] as String),
    );
  }

  final String id;
  final String studentId;
  final String subjectId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ParticipationModel copyWith({
    String? id,
    String? studentId,
    String? subjectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ParticipationModel(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      subjectId: subjectId ?? this.subjectId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Mapper<dynamic> toJson() {
    return {
      'student_id': studentId,
      'subject_id': subjectId,
      'updated_at': DateTime.now().toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'ParticipationModel(id: $id, studentId: $studentId, subjectId: $subjectId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ParticipationModel &&
        other.id == id &&
        other.studentId == studentId &&
        other.subjectId == subjectId &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        studentId.hashCode ^
        subjectId.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}

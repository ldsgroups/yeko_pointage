import 'package:flutter/foundation.dart';
import 'package:yeko_pointage/core/core.dart';

AttendanceStatus toAttendanceStatus(String type) {
  switch (type) {
    case 'present':
      return AttendanceStatus.present;
    case 'absent':
      return AttendanceStatus.absent;
    case 'late':
      return AttendanceStatus.late;
    default:
      return AttendanceStatus.present;
  }
}

String fromAttendanceStatus(AttendanceStatus type) {
  switch (type) {
    case AttendanceStatus.present:
      return 'present';
    case AttendanceStatus.absent:
      return 'absent';
    case AttendanceStatus.late:
      return 'late';
    default:
      return 'present';
  }
}

@immutable
class AttendanceModel {
  const AttendanceModel({
    required this.id,
    required this.studentId,
    required this.status,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AttendanceModel.fromJson({required Mapper<dynamic> json}) {
    return AttendanceModel(
      id: json['id'] as String,
      studentId: json['student_id'] as String,
      status: toAttendanceStatus(json['status'] as String),
      date: DateTime.parse(json['date'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  final String id;
  final String studentId;
  final AttendanceStatus status;
  final DateTime date;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AttendanceModel copyWith({
    String? id,
    String? studentId,
    AttendanceStatus? status,
    DateTime? date,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AttendanceModel(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      status: status ?? this.status,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Mapper<dynamic> toJson() {
    return {
      'id': id,
      'student_id': studentId,
      'status': fromAttendanceStatus(status),
      'date': date.toIso8601String(),
      'created_at': createdAt!.toIso8601String(),
      'updated_at': updatedAt!.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'AttendanceModel(id: $id, studentId: $studentId, status: $status, date: $date, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AttendanceModel &&
        other.id == id &&
        other.studentId == studentId &&
        other.status == status &&
        other.date == date &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        studentId.hashCode ^
        status.hashCode ^
        date.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' as material;
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
    this.id = '',
    required this.studentId,
    this.studentName = '',
    required this.status,
    required this.isExcused,
    this.statusLabelAndColor = const AttendanceColorModel(
      label: 'Présent',
      color: material.Colors.green,
    ),
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AttendanceModel.fromJson({required Mapper<dynamic> json}) {
    return AttendanceModel(
      id: json['id'] == null ? '' : json['id'] as String,
      studentId: json['student_id'] as String,
      studentName:
          json['student_name'] == null ? '' : json['student_name'] as String,
      status: toAttendanceStatus(json['status'] as String),
      isExcused:
          json['is_excused'] == null ? false : json['is_excused'] as bool,
      statusLabelAndColor: getAttendanceColor(
        toAttendanceStatus(json['status'] as String),
      ),
      date: DateTime.parse(json['date'] as String),
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
  final String studentName;
  final AttendanceStatus status;
  final bool isExcused;
  final AttendanceColorModel? statusLabelAndColor;
  final DateTime date;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AttendanceModel copyWith({
    String? id,
    String? studentId,
    String? studentName,
    AttendanceStatus? status,
    bool? isExcused,
    AttendanceColorModel? statusLabelAndColor,
    DateTime? date,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AttendanceModel(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      studentName: studentName ?? this.studentName,
      status: status ?? this.status,
      isExcused: isExcused ?? this.isExcused,
      statusLabelAndColor: statusLabelAndColor ?? this.statusLabelAndColor,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Mapper<dynamic> toJson() {
    return {
      'student_id': studentId,
      'student_name': studentName,
      'status': fromAttendanceStatus(status),
      'is_excused': isExcused,
      'date': date.toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'AttendanceModel(id: $id, studentId: $studentId, studentName: $studentName, status: $status, isExcused: $isExcused, statusLabelAndColor: $statusLabelAndColor, date: $date, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AttendanceModel &&
        other.id == id &&
        other.studentId == studentId &&
        other.studentName == studentName &&
        other.status == status &&
        other.isExcused == isExcused &&
        other.statusLabelAndColor == statusLabelAndColor &&
        other.date == date &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        studentId.hashCode ^
        studentName.hashCode ^
        status.hashCode ^
        isExcused.hashCode ^
        statusLabelAndColor.hashCode ^
        date.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}

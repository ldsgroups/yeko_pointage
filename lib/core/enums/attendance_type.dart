import 'package:flutter/material.dart';

/// Represents different types of attendance.
///
/// The `AttendanceType` enum is used to determine student attendance inn classroom.
///
/// Usage example:
/// ```dart
/// AttendanceType attendance = AttendanceType.present;
/// if (attendance == AttendanceType.present) {
///   print('Student is present');
/// } else if (attendance == AttendanceType.absent) {
///   print('Student is absent');
/// }
/// ```
enum AttendanceStatus {
  /// Represents the present case of attendance.
  present,

  /// Represents the absent case of attendance.
  absent,

  /// Represents the late case of attendance.
  late,
}

class AttendanceColorModel {
  const AttendanceColorModel({
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;
}

AttendanceColorModel getAttendanceColor(AttendanceStatus? status) {
  switch (status) {
    case AttendanceStatus.absent:
      return const AttendanceColorModel(
        label: 'Absent',
        color: Colors.redAccent,
      );
    case AttendanceStatus.late:
      return const AttendanceColorModel(
        label: 'Retard',
        color: Colors.orangeAccent,
      );
    default:
      return const AttendanceColorModel(
        label: 'Présent',
        color: Colors.green,
      );
  }
}

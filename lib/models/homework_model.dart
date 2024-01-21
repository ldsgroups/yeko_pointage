import 'package:flutter/foundation.dart';
import 'package:yeko_pointage/core/core.dart';

@immutable
class HomeworkModel {
  const HomeworkModel({
    this.id = '',
    required this.classId,
    required this.subjectId,
    required this.dueDate,
    required this.itWillBeANote,
    required this.createdAt,
    required this.updatedAt,
  });

  factory HomeworkModel.fromJson({required Mapper<dynamic> json}) {
    return HomeworkModel(
      id: json['id'] == null ? '' : json['id'] as String,
      classId: json['class_id'] as String,
      subjectId: json['subject_id'] as String,
      dueDate: DateTime.parse(json['due_date'] as String),
      itWillBeANote: json['it_will_be_a_note'] as bool,
      createdAt: json['created_at'] == null
          ? DateTime.now()
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(json['updated_at'] as String),
    );
  }

  final String id;
  final String classId;
  final String subjectId;
  final DateTime dueDate;
  final bool itWillBeANote;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  HomeworkModel copyWith({
    String? id,
    String? classId,
    String? subjectId,
    DateTime? dueDate,
    bool? itWillBeANote,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return HomeworkModel(
      id: id ?? this.id,
      classId: classId ?? this.classId,
      subjectId: subjectId ?? this.subjectId,
      dueDate: dueDate ?? this.dueDate,
      itWillBeANote: itWillBeANote ?? this.itWillBeANote,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Mapper<dynamic> toJson() {
    return {
      'class_id': classId,
      'subject_id': subjectId,
      'due_date': dueDate.toIso8601String(),
      'it_will_be_a_note': itWillBeANote,
    };
  }

  @override
  String toString() {
    return 'HomeworkModel(id: $id, classId: $classId, subjectId: $subjectId, '
        'dueDate: $dueDate, itWillBeANote: $itWillBeANote, createdAt: '
        '$createdAt, updatedAt: '
        '$updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeworkModel &&
        other.id == id &&
        other.classId == classId &&
        other.subjectId == subjectId &&
        other.dueDate == dueDate &&
        other.itWillBeANote == itWillBeANote &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        classId.hashCode ^
        subjectId.hashCode ^
        dueDate.hashCode ^
        itWillBeANote.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}

import 'package:flutter/foundation.dart';
import 'package:yeko_pointage/core/core.dart';
import 'package:yeko_pointage/models/models.dart';

@immutable
class ClassModel {
  const ClassModel({
    required this.id,
    required this.name,
    this.mainTeacherId = '',
    this.students = const <StudentModel>[],
  });

  factory ClassModel.fromJson({required Mapper<dynamic> json}) {
    return ClassModel(
      id: json['id'] as String,
      name: json['name'] as String,
      mainTeacherId: json['main_teacher_id'] == null
          ? ''
          : json['main_teacher_id'] as String,
      students: json.containsKey('students')
          ? (json['students'] as List)
              .map(
                (e) => StudentModel.fromJson(json: e as Mapper<dynamic>),
              )
              .toList()
          : <StudentModel>[],
    );
  }

  final String id;
  final String name;
  final String mainTeacherId;
  final List<StudentModel> students;

  Mapper<dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'students': students,
      'updated_at': DateTime.now().toIso8601String(),
    };
  }

  ClassModel copyWith({
    String? id,
    String? name,
    String? mainTeacherId,
    List<StudentModel>? students,
  }) {
    return ClassModel(
      id: id ?? this.id,
      name: name ?? this.name,
      mainTeacherId: mainTeacherId ?? this.mainTeacherId,
      students: students ?? this.students,
    );
  }

  @override
  String toString() {
    return 'ClassModel(id: $id, name: $name, mainTeacherId: $mainTeacherId, students: $students)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClassModel &&
        other.id == id &&
        other.name == name &&
        other.mainTeacherId == mainTeacherId &&
        other.students == students;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        mainTeacherId.hashCode ^
        students.hashCode;
  }
}

const emptyClass = ClassModel(id: '', name: '');

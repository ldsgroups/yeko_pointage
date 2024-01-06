import 'package:flutter/foundation.dart';
import 'package:yeko_pointage/core/core.dart';

@immutable
class StudentModel {
  const StudentModel({
    required this.id,
    required this.parentId,
    required this.idNumber,
    required this.fullName,
  });

  factory StudentModel.fromJson({required Mapper<dynamic> json}) {
    return StudentModel(
      id: json['id'] as String,
      parentId: json['parent_id'] as String,
      idNumber: json['id_number'] as String,
      fullName: json['full_name'] as String,
    );
  }

  final String id;
  final String parentId;
  final String idNumber;
  final String fullName;

  Mapper<dynamic> toJson() {
    return {
      'id': id,
      'parent_id': parentId,
      'id_number': idNumber,
      'full_name': fullName,
    };
  }

  StudentModel copyWith({
    String? id,
    String? parentId,
    String? idNumber,
    String? fullName,
  }) {
    return StudentModel(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      idNumber: idNumber ?? this.idNumber,
      fullName: fullName ?? this.fullName,
    );
  }

  @override
  String toString() {
    return 'StudentModel(id: $id, parentId: $parentId, idNumber: $idNumber, fullName: $fullName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StudentModel &&
        other.id == id &&
        other.parentId == parentId &&
        other.idNumber == idNumber &&
        other.fullName == fullName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        parentId.hashCode ^
        idNumber.hashCode ^
        fullName.hashCode;
  }
}

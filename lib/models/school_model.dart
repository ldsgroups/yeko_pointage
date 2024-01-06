import 'package:flutter/foundation.dart';
import 'package:yeko_pointage/core/core.dart';

@immutable
class SchoolModel {
  const SchoolModel({
    required this.id,
    required this.name,
    required this.cycleId,
    required this.isTechnicalEducation,
  });

  factory SchoolModel.fromJson({required Mapper<dynamic> json}) {
    return SchoolModel(
      id: json['id'] as String,
      name: json['name'] as String,
      cycleId: json['cycle_id'] as String,
      isTechnicalEducation: json['is_technical_education'] as bool,
    );
  }

  final String id;
  final String name;
  final String cycleId;
  final bool isTechnicalEducation;

  Mapper<dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'cycle_id': cycleId,
      'is_technical_education': isTechnicalEducation,
    };
  }

  SchoolModel copyWith({
    String? id,
    String? name,
    String? cycleId,
    bool? isTechnicalEducation,
  }) {
    return SchoolModel(
      id: id ?? this.id,
      name: name ?? this.name,
      cycleId: cycleId ?? this.cycleId,
      isTechnicalEducation: isTechnicalEducation ?? this.isTechnicalEducation,
    );
  }

  @override
  String toString() {
    return 'SchoolModel(id: $id, name: $name, cycleId: $cycleId, isTechnicalEducation: $isTechnicalEducation)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SchoolModel &&
        other.id == id &&
        other.name == name &&
        other.cycleId == cycleId &&
        other.isTechnicalEducation == isTechnicalEducation;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        cycleId.hashCode ^
        isTechnicalEducation.hashCode;
  }
}

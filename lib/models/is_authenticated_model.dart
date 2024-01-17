import 'package:flutter/foundation.dart';

@immutable
class IsAuthenticatedModel {
  const IsAuthenticatedModel({
    this.isAuthenticated = false,
    this.isLinkedToASchool = false,
  });

  final bool isAuthenticated;
  final bool isLinkedToASchool;

  IsAuthenticatedModel copyWith({
    bool? isAuthenticated,
    bool? isLinkedToASchool,
  }) {
    return IsAuthenticatedModel(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLinkedToASchool: isLinkedToASchool ?? this.isLinkedToASchool,
    );
  }
}

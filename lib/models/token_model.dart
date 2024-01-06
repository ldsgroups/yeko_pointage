import 'package:flutter/foundation.dart';
import 'package:yeko_pointage/core/core.dart';

@immutable
class TokenModel {
  const TokenModel({
    required this.type,
    required this.token,
    required this.expiresAt,
  });

  factory TokenModel.fromJson({required Mapper<dynamic> json}) {
    return TokenModel(
      type: json['type'] as String,
      token: json['token'] as String,
      expiresAt: DateTime.parse(json['expires_at'] as String),
    );
  }

  final String type;
  final String token;
  final DateTime expiresAt;

  Mapper<dynamic> toJson() {
    return {
      'type': type,
      'token': token,
      'expires_at': expiresAt.toIso8601String(),
    };
  }

  TokenModel copyWith({
    String? type,
    String? token,
    DateTime? expiresAt,
  }) {
    return TokenModel(
      type: type ?? this.type,
      token: token ?? this.token,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }

  @override
  String toString() {
    return 'TokenModel(type: $type, token: $token, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TokenModel &&
        other.type == type &&
        other.token == token &&
        other.expiresAt == expiresAt;
  }

  @override
  int get hashCode {
    return type.hashCode ^ token.hashCode ^ expiresAt.hashCode;
  }
}

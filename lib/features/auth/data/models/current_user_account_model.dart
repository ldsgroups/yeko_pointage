import 'package:yeko_pointage/features/auth/business/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.id = '',
    super.email,
    super.phone,
    super.lastSignInAt,
  });

  factory UserModel.fromJson({required Map<String, dynamic> json}) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      lastSignInAt: json['last_sign_in_at'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'last_sign_in_at': lastSignInAt,
    };
  }
}

import 'package:yeko_pointage/features/auth/business/entities/sign_in_entity.dart';

class SignInModel extends SignInEntity {
  const SignInModel({
    required super.email,
    required super.password,
  });

  factory SignInModel.fromJson({required Map<String, dynamic> json}) {
    return SignInModel(
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

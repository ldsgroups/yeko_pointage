class UserEntity {
  const UserEntity({
    this.id = '',
    this.email,
    this.phone,
    this.lastSignInAt,
  });

  final String id;
  final String? email;
  final String? phone;
  final String? lastSignInAt;

  /// Returns a `UserEntity` object from a map of json
  /// returns `null` if there is no `id` present
  static UserEntity? fromJson(Map<String, dynamic> json) {
    if (json['id'] == null || json['id'] == '') {
      return null;
    }

    return UserEntity(
      id: json['id'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      lastSignInAt: json['last_sign_in_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'last_sign_in_at': lastSignInAt,
    };
  }

  @override
  String toString() {
    return 'User(id: $id, email: $email, phone: $phone, lastSignInAt: $lastSignInAt)';
  }
}

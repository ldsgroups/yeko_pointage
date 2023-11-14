import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yeko_pointage/core/errors/exceptions.dart';
import 'package:yeko_pointage/features/auth/data/models/current_user_account_model.dart';

abstract class CurrentUserAccountRemoteDataSource {
  Future<UserModel?> runCurrentUserAccount();
}

class CurrentUserAccountRemoteDataSourceImpl
    implements CurrentUserAccountRemoteDataSource {
  CurrentUserAccountRemoteDataSourceImpl({required this.goTrueClient});

  final GoTrueClient goTrueClient;

  @override
  Future<UserModel?> runCurrentUserAccount() async {
    try {
      final response = goTrueClient.currentUser;

      final user = response == null
          ? null
          : UserModel(
              id: response.id,
              phone: response.phone,
              email: response.email,
              lastSignInAt: response.lastSignInAt,
            );

      return user;
    } on AuthException catch (_) {
      throw ServerException();
    } catch (_) {
      throw ServerException();
    }
  }
}

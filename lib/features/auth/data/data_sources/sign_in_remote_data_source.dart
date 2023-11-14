import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yeko_pointage/core/errors/exceptions.dart';
import 'package:yeko_pointage/core/params/params.dart';

abstract class SignInRemoteDataSource {
  Future<void> runSignIn({required SignInParams signInParams});
}

class SignInRemoteDataSourceImpl implements SignInRemoteDataSource {
  SignInRemoteDataSourceImpl({required this.goTrueClient});

  final GoTrueClient goTrueClient;

  @override
  Future<void> runSignIn({
    required SignInParams signInParams,
  }) async {
    try {
      await goTrueClient.signInWithPassword(
        email: signInParams.email,
        password: signInParams.password,
      );
    } on AuthException catch (_) {
      throw ServerException();
    } catch (_) {
      throw ServerException();
    }
  }
}

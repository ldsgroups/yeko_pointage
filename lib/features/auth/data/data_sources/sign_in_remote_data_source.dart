import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yeko_pointage/core/errors/exceptions.dart';
import 'package:yeko_pointage/core/params/params.dart';

abstract class SignInRemoteDataSource {
  Future<AuthResponse> runSignIn({required SignInParams signInParams});
}

class SignInRemoteDataSourceImpl implements SignInRemoteDataSource {
  SignInRemoteDataSourceImpl({required this.goTrueClient});

  final GoTrueClient goTrueClient;

  @override
  Future<AuthResponse> runSignIn({
    required SignInParams signInParams,
  }) async {
    try {
      final response = await goTrueClient.signInWithPassword(
        email: signInParams.email,
        password: signInParams.password,
      );
      print('=======[ SUCCESS ]=======');
      print(response.session?.user.email);
      return response;
    } on AuthException catch (e) {
      print('=======[ Appwrite ERROR ]=======');
      print(e.message);
      throw ServerException();
    } catch (e) {
      print('=======[ Local ERROR ]=======');
      print(e);
      throw ServerException();
    }
  }
}

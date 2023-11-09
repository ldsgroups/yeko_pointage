import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:yeko_pointage/core/errors/exceptions.dart';
import 'package:yeko_pointage/core/params/params.dart';

abstract class SignInRemoteDataSource {
  Future<Session> runSignIn({required SignInParams signInParams});
}

class SignInRemoteDataSourceImpl implements SignInRemoteDataSource {
  SignInRemoteDataSourceImpl({required this.account});

  final Account account;

  @override
  Future<Session> runSignIn({
    required SignInParams signInParams,
  }) async {
    try {
      final response = await account.createEmailSession(
        email: signInParams.email,
        password: signInParams.password,
      );
      return response;
    } on AppwriteException catch (e) {
      print('=======[ Appwrite ERROR ]=======');
      print(e.message ?? 'Une erreur appwrite');
      throw ServerException();
    } catch (e) {
      print('=======[ Local ERROR ]=======');
      print(e);
      throw ServerException();
    }
  }
}

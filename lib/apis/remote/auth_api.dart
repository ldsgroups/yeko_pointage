import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yeko_pointage/core/core.dart';
import 'package:yeko_pointage/models/models.dart';

part 'auth_api.g.dart';

@riverpod
AuthAPI authAPI(
  AuthAPIRef ref,
) =>
    AuthAPI(dio: ref.watch(dioInstanceAuthProvider));

abstract class IAuthAPI {
  FutureEither<TokenModel?> signInWithUidAndPassword({
    required String uid,
    required String password,
  });
}

class AuthAPI implements IAuthAPI {
  AuthAPI({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  FutureEither<TokenModel?> signInWithUidAndPassword({
    required String uid,
    required String password,
  }) async {
    try {
      final response = await _dio.request<Mapper<dynamic>>(
        '/auth/sign-in',
        options: Options(
          method: 'POST',
        ),
        data: {
          'uid': uid,
          'password': password,
        },
      );

      if (response.statusCode == 201) {
        final data = response.data!;
        final dt = TokenModel.fromJson(json: data);
        return right(dt);
      } else {
        throw Exception();
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
        return left(
          ServerFailure(
            errorMessage: 'Identifiant ou mot de passe incorrect',
          ),
        );
      } else {
        return left(
          ServerFailure(
            errorMessage: 'Une erreur est survenue',
          ),
        );
      }
    } catch (e) {
      return left(ServerFailure(errorMessage: 'Une erreur est survenue'));
    }
  }
}

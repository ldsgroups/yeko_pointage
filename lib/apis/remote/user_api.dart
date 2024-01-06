import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yeko_pointage/core/core.dart';
import 'package:yeko_pointage/models/models.dart';

part 'user_api.g.dart';

@riverpod
UserAPI userAPI(
  UserAPIRef ref,
) =>
    UserAPI(dio: ref.watch(dioInstanceProvider));

abstract class IUserAPI {
  FutureEither<UserModel?> me();
}

class UserAPI implements IUserAPI {
  UserAPI({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  FutureEither<UserModel> me() async {
    try {
      final response = await _dio.get<Mapper<dynamic>?>(
        '/users/me',
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final dt = UserModel.fromJson(json: data!);
        return right(dt);
      } else {
        throw Exception();
      }
    } on DioException catch (_) {
      return left(
        ServerFailure(
          errorMessage: 'Une erreur est survenue',
        ),
      );
    } catch (e) {
      return left(ServerFailure(errorMessage: 'Une erreur est survenue'));
    }
  }
}

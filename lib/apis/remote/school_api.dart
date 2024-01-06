import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yeko_pointage/core/core.dart';
import 'package:yeko_pointage/models/models.dart';

part 'school_api.g.dart';

@riverpod
SchoolAPI schoolAPI(
  SchoolAPIRef ref,
) =>
    SchoolAPI(dio: ref.watch(dioInstanceProvider));

abstract class ISchoolAPI {
  FutureEither<SchoolModel?> getSchool({required String schoolId});
}

class SchoolAPI implements ISchoolAPI {
  SchoolAPI({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  FutureEither<SchoolModel?> getSchool({required String schoolId}) async {
    try {
      final response = await _dio.get<Mapper<dynamic>>(
        '/schools/$schoolId',
        queryParameters: {},
      );

      print('============> [RESPONSE]: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = response.data?['data'] as Mapper<dynamic>;
        return right(SchoolModel.fromJson(json: data));
      } else {
        print('is not 200: ${response.data}');
        return right(null);
      }
    } on DioException catch (e) {
      print('===> $e');
      return left(
        ServerFailure(
          errorMessage: 'Une erreur est survenue',
        ),
      );
    } catch (e) {
      print(e);
      return left(
        ServerFailure(
          errorMessage: 'Une erreur est survenue',
        ),
      );
    }
  }
}

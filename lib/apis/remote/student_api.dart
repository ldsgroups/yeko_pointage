import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yeko_pointage/core/core.dart';
import 'package:yeko_pointage/models/models.dart';

part 'student_api.g.dart';

@riverpod
StudentAPI studentAPI(
  StudentAPIRef ref,
) =>
    StudentAPI(dio: ref.watch(dioInstanceProvider));

abstract class IStudentAPI {
  FutureEither<List<StudentModel>> getStudents({
    required String schoolId,
    required String classId,
  });
}

class StudentAPI implements IStudentAPI {
  StudentAPI({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  FutureEither<List<StudentModel>> getStudents({
    required String schoolId,
    required String classId,
  }) async {
    try {
      final response = await _dio.get<Mapper<dynamic>>(
        '/schools/$schoolId/class/$classId',
        queryParameters: {},
      );

      if (response.statusCode == 200) {
        final data = response.data?['data'] as List;
        print('===============');
        print({data});
        return right(
          data
              .map(
                (e) => StudentModel.fromJson(json: e as Mapper<dynamic>),
              )
              .toList(),
        );
      } else {
        return right([]);
      }
    } on DioException catch (e) {
      print(e);
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

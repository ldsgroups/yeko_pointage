import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yeko_pointage/core/core.dart';
import 'package:yeko_pointage/models/models.dart';

part 'class_api.g.dart';

@riverpod
ClassAPI classAPI(
  ClassAPIRef ref,
) =>
    ClassAPI(dio: ref.watch(dioInstanceProvider));

abstract class IClassAPI {
  FutureEither<List<ClassModel>> getClasses({required String schoolId});
  FutureEither<ClassModel?> getClass({
    required String schoolId,
    required String classId,
  });
}

class ClassAPI implements IClassAPI {
  ClassAPI({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  FutureEither<List<ClassModel>> getClasses({required String schoolId}) async {
    final response = await _dio.get<Mapper<dynamic>>(
      '/schools/$schoolId/classes',
      queryParameters: {},
    );

    if (response.statusCode == 200) {
      final data = response.data?['data'] as List;
      return right(
        data
            .map((e) => ClassModel.fromJson(json: e as Mapper<dynamic>))
            .toList(),
      );
    } else {
      throw ServerException();
    }
  }

  @override
  FutureEither<ClassModel?> getClass({
    required String schoolId,
    required String classId,
  }) async {
    final response = await _dio.get<Mapper<dynamic>>(
      '/schools/$schoolId/classes/$classId',
    );

    if (response.statusCode == 200) {
      final data = response.data?['data'] as Mapper<dynamic>;
      final dt = ClassModel.fromJson(json: data);
      return right(dt);
    } else {
      throw ServerException();
    }
  }
}

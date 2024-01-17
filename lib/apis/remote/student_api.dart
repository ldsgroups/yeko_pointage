import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yeko_pointage/core/core.dart';
import 'package:yeko_pointage/models/models.dart';

part 'student_api.g.dart';

@riverpod
StudentAPI studentAPI(
  StudentAPIRef ref,
) =>
    StudentAPI(db: ref.watch(supabaseClientProvider));

abstract class IStudentAPI {
  FutureEither<List<StudentModel>> getStudents({
    required String schoolId,
    required String classId,
  });
}

class StudentAPI implements IStudentAPI {
  StudentAPI({required SupabaseClient db}) : _db = db;

  final SupabaseClient _db;

  @override
  FutureEither<List<StudentModel>> getStudents({
    required String schoolId,
    required String classId,
  }) async {
    try {
      final response = await _db
          .from('students')
          .select()
          .eq('school_id', schoolId)
          .eq('class_id', classId)
          .then(
            (value) =>
                value.map((e) => StudentModel.fromJson(json: e)).toList(),
          );

      return right(response);
    } on PostgrestException catch (_) {
      return left(
        ServerFailure(
          errorMessage: 'Une erreur est survenue',
        ),
      );
    } catch (e) {
      return left(
        ServerFailure(
          errorMessage: 'Une erreur est survenue',
        ),
      );
    }
  }
}

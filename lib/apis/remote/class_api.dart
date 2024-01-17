import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yeko_pointage/core/core.dart';
import 'package:yeko_pointage/models/models.dart';

part 'class_api.g.dart';

@riverpod
ClassAPI classAPI(
  ClassAPIRef ref,
) =>
    ClassAPI(db: ref.watch(supabaseClientProvider));

abstract class IClassAPI {
  FutureEither<List<ClassModel>> getClasses({required String schoolId});

  FutureEither<ClassModel?> getClass({
    required String schoolId,
    required String classId,
  });

  FutureEitherVoid createAttendanceAndParticipationAndHomework({
    required List<AttendanceModel> attendances,
    required List<ParticipationModel> participations,
    HomeworkModel? homework,
  });
}

class ClassAPI implements IClassAPI {
  ClassAPI({required SupabaseClient db}) : _db = db;

  final SupabaseClient _db;

  @override
  FutureEither<List<ClassModel>> getClasses({required String schoolId}) async {
    try {
      final response =
          await _db.from('classes').select().eq('school_id', schoolId).then(
                (value) =>
                    value.map((e) => ClassModel.fromJson(json: e)).toList(),
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

  @override
  FutureEither<ClassModel?> getClass({
    required String schoolId,
    required String classId,
  }) async {
    try {
      final response = await _db
          .from('classes')
          .select()
          .eq('school_id', schoolId)
          .eq('id', classId)
          .then(
            (value) => value.isNotEmpty
                ? ClassModel.fromJson(json: value.first)
                : null,
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

  @override
  FutureEitherVoid createAttendanceAndParticipationAndHomework({
    required List<AttendanceModel> attendances,
    required List<ParticipationModel> participations,
    HomeworkModel? homework,
  }) async {
    try {
      final attendancesJson = attendances.map((e) => e.toJson()).toList();
      final participationsJson = participations.map((e) => e.toJson()).toList();
      final homeworkJson = homework?.toJson();

      final res = await _db.rpc<String>(
        'create_attendance_and_participation_and_homework',
        params: {
          'attendances': attendancesJson,
          'participations': participationsJson,
          'homework': homeworkJson,
        },
      );

      print('====================');
      print('$res');
      print('PASSED');

      return right(null);
    } on PostgrestException catch (err) {
      if (kDebugMode) {
        print('[E_POSTGRES] ${err.message}');
      }

      return left(
        ServerFailure(
          errorMessage: 'Une erreur est survenue',
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print('[E_LOCAL] $e');
      }
      return left(
        ServerFailure(
          errorMessage: 'Une erreur est survenue',
        ),
      );
    }
  }
}

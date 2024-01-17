import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yeko_pointage/core/core.dart';
import 'package:yeko_pointage/models/models.dart';

part 'school_api.g.dart';

@riverpod
SchoolAPI schoolAPI(
  SchoolAPIRef ref,
) =>
    SchoolAPI(db: ref.watch(supabaseClientProvider));

abstract class ISchoolAPI {
  FutureEither<SchoolModel?> getSchool({required String schoolId});
}

class SchoolAPI implements ISchoolAPI {
  SchoolAPI({required SupabaseClient db}) : _db = db;

  final SupabaseClient _db;

  @override
  FutureEither<SchoolModel?> getSchool({required String schoolId}) async {
    try {
      final response =
          await _db.from('schools').select().eq('id', schoolId).single().then(
                (value) => SchoolModel.fromJson(json: value),
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

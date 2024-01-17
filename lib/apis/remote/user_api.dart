import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yeko_pointage/core/core.dart';
import 'package:yeko_pointage/models/models.dart';

part 'user_api.g.dart';

@riverpod
UserAPI userAPI(
  UserAPIRef ref,
) =>
    UserAPI(db: ref.watch(supabaseClientProvider));

abstract class IUserAPI {
  FutureEither<UserModel?> me({required String userId});
  FutureEither<UserModel> createUserNewSignedUpId({
    required String id,
    required String email,
  });
}

class UserAPI implements IUserAPI {
  UserAPI({required SupabaseClient db}) : _db = db;

  final SupabaseClient _db;

  @override
  FutureEither<UserModel> me({required String userId}) async {
    try {
      final response = await _db
          .from('users')
          .select()
          .eq('id', userId)
          .single()
          .then((value) => UserModel.fromJson(json: value));

      return right(response);
    } on PostgrestException catch (_) {
      return left(
        ServerFailure(
          errorMessage: 'Une erreur est survenue',
        ),
      );
    } catch (e) {
      return left(ServerFailure(errorMessage: 'Une erreur est survenue'));
    }
  }

  @override
  FutureEither<UserModel> createUserNewSignedUpId({
    required String id,
    required String email,
  }) async {
    try {
      final response = await _db
          .from('users')
          .upsert(
            {
              'id': id,
              'email': email,
              'username': email.split('@').first,
            },
            onConflict: 'id',
          )
          .select()
          .single()
          .then(
            (value) => UserModel.fromJson(json: value),
          );

      return right(response);
    } on PostgrestException catch (err) {
      return left(
        ServerFailure(
          errorMessage: err.code == '23505'
              ? 'Cet email est déjà utilisé'
              : "Nous n'avons pas pu créer votre compte",
        ),
      );
    } catch (e) {
      return left(ServerFailure(errorMessage: 'Une erreur est survenue'));
    }
  }
}

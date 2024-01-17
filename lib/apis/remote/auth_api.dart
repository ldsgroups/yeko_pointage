import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yeko_pointage/core/core.dart';

part 'auth_api.g.dart';

@riverpod
AuthAPI authAPI(
  AuthAPIRef ref,
) =>
    AuthAPI(
      goTrueClient: ref.watch(supabaseAuthProvider),
    );

abstract class IAuthAPI {
  Future<String?> currentUserId();

  FutureEither<String?> signInWithUidAndPassword({
    required String email,
    required String password,
  });

  FutureEitherVoid signOut();
}

class AuthAPI implements IAuthAPI {
  AuthAPI({required GoTrueClient goTrueClient}) : _goTrueClient = goTrueClient;

  final GoTrueClient _goTrueClient;

  @override
  Future<String?> currentUserId() async {
    try {
      return _goTrueClient.currentUser?.id;
    } on AuthException {
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  FutureEither<String?> signInWithUidAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _goTrueClient.signInWithPassword(
        email: email,
        password: password,
      );

      return right(response.user?.id);
    } on AuthException catch (err) {
      if (kDebugMode) {
        print('[E_POSTGRES] ${err.message}');
      }
      return left(ServerFailure(errorMessage: err.message));
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

  @override
  FutureEitherVoid signOut() async {
    try {
      await _goTrueClient.signOut();
      return right(null);
    } on AuthException catch (err) {
      if (kDebugMode) {
        print('[E_POSTGRES] ${err.message}');
      }
      return left(ServerFailure(errorMessage: err.message));
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

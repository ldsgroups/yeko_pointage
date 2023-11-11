import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yeko_pointage/core/errors/failure.dart';
import 'package:yeko_pointage/core/params/params.dart';

abstract class SignInRepository {
  Future<Either<Failure, AuthResponse>> runSignIn({
    required SignInParams signInParams,
  });
}

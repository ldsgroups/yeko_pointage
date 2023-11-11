import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yeko_pointage/core/core.dart';
import 'package:yeko_pointage/features/auth/business/repositories/sign_in_repository.dart';

class RunSignIn {
  RunSignIn({required this.signInRepository});

  final SignInRepository signInRepository;

  Future<Either<Failure, AuthResponse>> call({
    required SignInParams signInParams,
  }) async {
    return signInRepository.runSignIn(signInParams: signInParams);
  }
}

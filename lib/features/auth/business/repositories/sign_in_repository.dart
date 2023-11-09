import 'package:appwrite/models.dart';
import 'package:fpdart/fpdart.dart';
import 'package:yeko_pointage/core/errors/failure.dart';
import 'package:yeko_pointage/core/params/params.dart';

abstract class SignInRepository {
  Future<Either<Failure, Session>> runSignIn({
    required SignInParams signInParams,
  });
}

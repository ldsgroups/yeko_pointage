import 'package:fpdart/fpdart.dart';
import 'package:yeko_pointage/core/errors/failure.dart';
import 'package:yeko_pointage/features/auth/business/entities/user_entity.dart';

abstract class CurrentUserAccountRepository {
  Future<Either<Failure, UserEntity?>> runCurrentUserAccount();
}

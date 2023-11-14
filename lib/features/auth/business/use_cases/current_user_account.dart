import 'package:fpdart/fpdart.dart';
import 'package:yeko_pointage/core/core.dart';
import 'package:yeko_pointage/features/auth/business/entities/user_entity.dart';
import 'package:yeko_pointage/features/auth/business/repositories/current_user_account_repository.dart';

class RunCurrentUserAccount {
  RunCurrentUserAccount({required this.currentUserAccountRepository});

  final CurrentUserAccountRepository currentUserAccountRepository;

  Future<Either<Failure, UserEntity?>> call() async {
    return currentUserAccountRepository.runCurrentUserAccount();
  }
}

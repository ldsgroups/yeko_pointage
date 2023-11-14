// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yeko_pointage/core/core.dart';
import 'package:yeko_pointage/features/auth/business/entities/user_entity.dart';
import 'package:yeko_pointage/features/auth/business/use_cases/current_user_account.dart';
import 'package:yeko_pointage/features/auth/data/data.dart';

part 'current_user_account_controller.g.dart';

@riverpod
Future<UserEntity?> isAuthenticated(
  IsAuthenticatedRef ref,
) async {
  final authCtrl = ref.read(currentUserAccountControllerProvider.notifier);

  final payload = await authCtrl.eitherFailureOrCurrentUserAccount();
  return payload.fold((l) => null, (r) => r);
}

@riverpod
class CurrentUserAccountController extends _$CurrentUserAccountController {
  @override
  bool build() => false;

  Future<Either<Failure, UserEntity?>>
      eitherFailureOrCurrentUserAccount() async {
    final repository = CurrentUserAccountRepositoryImpl(
      remoteDataSource: CurrentUserAccountRemoteDataSourceImpl(
        goTrueClient: ref.watch(supabaseAuthProvider),
      ),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );

    final failureOrCurrentUserAccount = await RunCurrentUserAccount(
      currentUserAccountRepository: repository,
    ).call();

    return failureOrCurrentUserAccount;
  }
}

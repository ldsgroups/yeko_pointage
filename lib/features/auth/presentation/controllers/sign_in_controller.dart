// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:appwrite/models.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yeko_pointage/core/core.dart';
import 'package:yeko_pointage/features/auth/business/business.dart';
import 'package:yeko_pointage/features/auth/data/data.dart';

part 'sign_in_controller.g.dart';

@riverpod
class SignInController extends _$SignInController {
  @override
  bool build() => false;

  Future<Either<Failure, Session>> eitherFailureOrSignIn({
    required String email,
    required String password,
  }) async {
    state = true;

    final repository = SignInRepositoryImpl(
      remoteDataSource: SignInRemoteDataSourceImpl(
        account: ref.watch(appwriteAccountProvider),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrSignIn = await RunSignIn(signInRepository: repository).call(
      signInParams: SignInParams(email: email, password: password),
    );

    state = false;
    return failureOrSignIn;
  }
}

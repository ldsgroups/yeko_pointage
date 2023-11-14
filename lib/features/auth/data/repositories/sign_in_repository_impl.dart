import 'package:fpdart/fpdart.dart';
import 'package:yeko_pointage/core/core.dart';
import 'package:yeko_pointage/features/auth/business/repositories/sign_in_repository.dart';
import 'package:yeko_pointage/features/auth/data/data_sources/sign_in_remote_data_source.dart';

class SignInRepositoryImpl implements SignInRepository {
  SignInRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  final SignInRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, void>> runSignIn({
    required SignInParams signInParams,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        await remoteDataSource.runSignIn(signInParams: signInParams);

        return const Right(null);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'Une erreur est survenue'));
      }
    } else {
      return Left(
        ServerFailure(errorMessage: 'Vérifier votre connexion internet'),
      );
    }
  }
}

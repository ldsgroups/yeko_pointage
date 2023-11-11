import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
  Future<Either<Failure, AuthResponse>> runSignIn({
    required SignInParams signInParams,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteSignIn =
            await remoteDataSource.runSignIn(signInParams: signInParams);

        return Right(remoteSignIn);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'Une erreur est survenue'));
      }
    } else {
      try {
        final remoteSignIn =
            await remoteDataSource.runSignIn(signInParams: signInParams);

        return Right(remoteSignIn);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'Une erreur est survenue'));
      }
      return Left(
        ServerFailure(errorMessage: 'Vérifier votre connexion internet'),
      );
    }
  }
}

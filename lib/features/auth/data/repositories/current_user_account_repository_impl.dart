import 'package:fpdart/fpdart.dart';
import 'package:yeko_pointage/core/core.dart';
import 'package:yeko_pointage/features/auth/business/repositories/current_user_account_repository.dart';
import 'package:yeko_pointage/features/auth/data/data_sources/current_user_account_remote_data_source.dart';
import 'package:yeko_pointage/features/auth/data/models/current_user_account_model.dart';

class CurrentUserAccountRepositoryImpl implements CurrentUserAccountRepository {
  CurrentUserAccountRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  final CurrentUserAccountRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, UserModel?>> runCurrentUserAccount() async {
    if (await networkInfo.isConnected!) {
      try {
        final response = await remoteDataSource.runCurrentUserAccount();

        return Right(response);
      } on ServerException {
        return Left(ServerFailure(errorMessage: "Vous n'êtes pas connecter"));
      }
    } else {
      return Left(
        ServerFailure(errorMessage: 'Vérifier votre connexion internet'),
      );
    }
  }
}

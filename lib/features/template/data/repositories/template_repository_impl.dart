import 'package:fpdart/fpdart.dart';
import 'package:yeko_pointage/core/core.dart';
import 'package:yeko_pointage/features/template/business/repositories/template_repository.dart';
import 'package:yeko_pointage/features/template/data/data_sources/template_local_data_source.dart';
import 'package:yeko_pointage/features/template/data/data_sources/template_remote_data_source.dart';
import 'package:yeko_pointage/features/template/data/models/template_model.dart';

class TemplateRepositoryImpl implements TemplateRepository {
  TemplateRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  final TemplateRemoteDataSource remoteDataSource;
  final TemplateLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, TemplateModel>> getTemplate({
    required TemplateParams templateParams,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteTemplate =
            await remoteDataSource.getTemplate(templateParams: templateParams);

        await localDataSource.cacheTemplate(templateToCache: remoteTemplate);

        return Right(remoteTemplate);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      try {
        final localTemplate = await localDataSource.getLastTemplate();
        return Right(localTemplate);
      } on CacheException {
        return Left(CacheFailure(errorMessage: 'This is a cache exception'));
      }
    }
  }
}

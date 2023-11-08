import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yeko_pointage/core/core.dart';
import 'package:yeko_pointage/features/template/business/business.dart';
import 'package:yeko_pointage/features/template/data/data.dart';

part 'template_provider.g.dart';

@riverpod
class TemplateProvider extends _$TemplateProvider {
  @override
  bool build() => false;

  late TemplateEntity? template;
  late Failure? failure;

  Future<void> eitherFailureOrTemplate() async {
    final repository = TemplateRepositoryImpl(
      remoteDataSource: TemplateRemoteDataSourceImpl(
        db: ref.watch(appwriteDatabaseProvider),
      ),
      localDataSource: TemplateLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrTemplate =
        await GetTemplate(templateRepository: repository).call(
      templateParams: TemplateParams(),
    );

    failureOrTemplate.fold(
      (newFailure) {
        template = null;
        failure = newFailure;
      },
      (newTemplate) {
        template = newTemplate;
        failure = null;
      },
    );
  }
}

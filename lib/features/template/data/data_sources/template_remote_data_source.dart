import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yeko_pointage/core/errors/exceptions.dart';
import 'package:yeko_pointage/core/params/params.dart';
import 'package:yeko_pointage/features/template/data/models/template_model.dart';

abstract class TemplateRemoteDataSource {
  Future<TemplateModel> getTemplate({required TemplateParams templateParams});
}

class TemplateRemoteDataSourceImpl implements TemplateRemoteDataSource {
  TemplateRemoteDataSourceImpl({required this.goTrueClient});

  final GoTrueClient goTrueClient;

  @override
  Future<TemplateModel> getTemplate({
    required TemplateParams templateParams,
  }) async {
    // Fetch remote data
    const fake = 1;

    if (1 != fake) {
      // return TemplateModel.fromJson(json: response.data);
      return const TemplateModel(template: '');
    } else {
      throw ServerException();
    }
  }
}

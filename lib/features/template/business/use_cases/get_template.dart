import 'package:fpdart/fpdart.dart';
import 'package:yeko_pointage/core/errors/failure.dart';
import 'package:yeko_pointage/core/params/params.dart';
import 'package:yeko_pointage/features/template/business/entities/template_entity.dart';
import 'package:yeko_pointage/features/template/business/repositories/template_repository.dart';

class GetTemplate {
  GetTemplate({required this.templateRepository});

  final TemplateRepository templateRepository;

  Future<Either<Failure, TemplateEntity>> call({
    required TemplateParams templateParams,
  }) async {
    return templateRepository.getTemplate(templateParams: templateParams);
  }
}

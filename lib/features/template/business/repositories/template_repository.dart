import 'package:fpdart/fpdart.dart';
import 'package:yeko_pointage/core/errors/failure.dart';
import 'package:yeko_pointage/core/params/params.dart';
import 'package:yeko_pointage/features/template/business/entities/template_entity.dart';

abstract class TemplateRepository {
  Future<Either<Failure, TemplateEntity>> getTemplate({
    required TemplateParams templateParams,
  });
}

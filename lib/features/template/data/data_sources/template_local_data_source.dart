import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:yeko_pointage/core/errors/exceptions.dart';
import 'package:yeko_pointage/features/template/data/models/template_model.dart';

abstract class TemplateLocalDataSource {
  Future<void> cacheTemplate({required TemplateModel? templateToCache});
  Future<TemplateModel> getLastTemplate();
}

const cachedTemplate = 'CACHED_TEMPLATE';

class TemplateLocalDataSourceImpl implements TemplateLocalDataSource {
  TemplateLocalDataSourceImpl({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  @override
  Future<TemplateModel> getLastTemplate() {
    final jsonString = sharedPreferences.getString(cachedTemplate);

    if (jsonString != null) {
      return Future.value(
        // TemplateModel.fromJson(json: jsonDecode(jsonString)),
        const TemplateModel(template: ''),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheTemplate({required TemplateModel? templateToCache}) async {
    if (templateToCache != null) {
      await sharedPreferences.setString(
        cachedTemplate,
        json.encode(
          templateToCache.toJson(),
        ),
      );
    } else {
      throw CacheException();
    }
  }
}

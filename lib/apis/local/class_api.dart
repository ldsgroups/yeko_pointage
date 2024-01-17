import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yeko_pointage/core/core.dart';
import 'package:yeko_pointage/models/models.dart';

part 'class_api.g.dart';

@riverpod
ClassLocalAPI classLocalAPI(
  ClassLocalAPIRef ref,
) =>
    ClassLocalAPI();

abstract class IClassLocalAPI {
  Future<void> cacheClass({required ClassModel? classToCache});
  Future<ClassModel> getLastClass();
}

class ClassLocalAPI implements IClassLocalAPI {
  ClassLocalAPI();

  @override
  Future<ClassModel> getLastClass() {
    final jsonString = PreferenceUtils.getString(PrefConst.classData);

    if (jsonString.isNotEmpty) {
      return Future.value(
        ClassModel.fromJson(
          json: jsonDecode(jsonString) as Mapper<dynamic>,
        ),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheClass({required ClassModel? classToCache}) async {
    if (classToCache != null) {
      await PreferenceUtils.setString(
        PrefConst.classData,
        json.encode(
          classToCache.toJson(),
        ),
      );
    } else {
      throw CacheException();
    }
  }
}

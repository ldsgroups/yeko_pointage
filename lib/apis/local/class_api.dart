import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yeko_pointage/core/core.dart';
import 'package:yeko_pointage/models/models.dart';

part 'class_api.g.dart';

@riverpod
ClassLocalAPI classLocalAPI(
  ClassLocalAPIRef ref,
  SharedPreferences sharedPrefs,
) =>
    ClassLocalAPI(sharedPrefs: sharedPrefs);

abstract class IClassLocalAPI {
  Future<void> cacheClass({required ClassModel? classToCache});
  Future<ClassModel> getLastClass();
}

class ClassLocalAPI implements IClassLocalAPI {
  ClassLocalAPI({required this.sharedPrefs});

  final SharedPreferences sharedPrefs;

  @override
  Future<ClassModel> getLastClass() {
    final jsonString = sharedPrefs.getString(SharedPrefsConstants.classData);

    if (jsonString != null) {
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
      await sharedPrefs.setString(
        SharedPrefsConstants.classData,
        json.encode(
          classToCache.toJson(),
        ),
      );
    } else {
      throw CacheException();
    }
  }
}

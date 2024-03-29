// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yeko_pointage/apis/apis.dart';
import 'package:yeko_pointage/core/core.dart';
import 'package:yeko_pointage/models/models.dart';

part 'setting_controller.g.dart';

@riverpod
class ClassesData extends _$ClassesData {
  @override
  List<ClassModel> build() => [];

  Future<void> updateClassesList(List<ClassModel> lc) async => state = lc;
}

@riverpod
class SettingController extends _$SettingController {
  @override
  bool build() => false;

  Future<void> getClasses({required String schoolId}) async {
    final classAPI = ref.read(classAPIProvider);

    final payload = await classAPI.getClasses(schoolId: schoolId);

    payload.fold((_) => null, (r) {
      final classesDataCtrl = ref.read(classesDataProvider.notifier);

      classesDataCtrl.updateClassesList(r);

      return r;
    });
  }

  Future<ClassModel?> setOwnerToTablet({
    required String schoolId,
    required String classId,
  }) async {
    final classAPI = ref.read(classAPIProvider);
    final classLocalAPI = ref.read(classLocalAPIProvider);

    final payload = await classAPI.getClass(
      schoolId: schoolId,
      classId: classId,
    );

    return payload.fold((_) => null, (r) async {
      await PreferenceUtils.removeKeys([]);
      await PreferenceUtils.setString(
        PrefConst.classId,
        r!.id,
      );

      await classLocalAPI.cacheClass(classToCache: r);
      return r;
    });
  }
}

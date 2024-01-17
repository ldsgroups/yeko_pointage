import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yeko_pointage/core/core.dart';
import 'package:yeko_pointage/models/models.dart';

part 'attendance_api.g.dart';

@riverpod
AttendanceLocalAPI attendanceLocalAPI(
  AttendanceLocalAPIRef ref,
) =>
    AttendanceLocalAPI();

abstract class IAttendanceLocalAPI {
  Future<void> cacheAttendances({
    required List<AttendanceModel> attendancesToCache,
  });
  Future<List<AttendanceModel>> getLastAttendances();
}

class AttendanceLocalAPI implements IAttendanceLocalAPI {
  AttendanceLocalAPI();

  @override
  Future<List<AttendanceModel>> getLastAttendances() {
    final jsonString = PreferenceUtils.getString(PrefConst.attendanceData);
    if (jsonString.isEmpty) return Future.value(<AttendanceModel>[]);
    final json = jsonDecode(jsonString) as List;

    return Future.value(
      json
          .map(
            (el) => AttendanceModel.fromJson(json: el as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  @override
  Future<void> cacheAttendances({
    required List<AttendanceModel> attendancesToCache,
  }) async {
    if (attendancesToCache.isNotEmpty) {
      final attendancesToJson = attendancesToCache
          .map(
            (attendanceToCache) => attendanceToCache.toJson(),
          )
          .toList();

      await PreferenceUtils.setString(
        PrefConst.attendanceData,
        json.encode(
          attendancesToJson,
        ),
      );
    } else {
      throw CacheException();
    }
  }
}

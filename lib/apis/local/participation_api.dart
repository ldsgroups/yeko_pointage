import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yeko_pointage/core/core.dart';
import 'package:yeko_pointage/models/models.dart';

part 'participation_api.g.dart';

@riverpod
ParticipationLocalAPI participationLocalAPI(
  ParticipationLocalAPIRef ref,
) =>
    ParticipationLocalAPI();

abstract class IParticipationLocalAPI {
  Future<void> cacheParticipations({
    required List<ParticipationModel> participationsToCache,
  });
  Future<List<ParticipationModel>> getLastParticipations();
}

class ParticipationLocalAPI implements IParticipationLocalAPI {
  ParticipationLocalAPI();

  @override
  Future<List<ParticipationModel>> getLastParticipations() {
    final jsonString = PreferenceUtils.getString(PrefConst.participationData);
    if (jsonString.isEmpty) return Future.value(<ParticipationModel>[]);
    final json = jsonDecode(jsonString) as List;

    return Future.value(
      json
          .map(
            (el) =>
                ParticipationModel.fromJson(json: el as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  @override
  Future<void> cacheParticipations({
    required List<ParticipationModel> participationsToCache,
  }) async {
    if (participationsToCache.isNotEmpty) {
      final participationsToJson = participationsToCache
          .map(
            (participationToCache) => participationToCache.toJson(),
          )
          .toList();

      await PreferenceUtils.setString(
        PrefConst.participationData,
        json.encode(
          participationsToJson,
        ),
      );
    } else {
      throw CacheException();
    }
  }
}

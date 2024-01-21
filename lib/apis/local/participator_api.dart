import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yeko_pointage/core/core.dart';
import 'package:yeko_pointage/models/models.dart';

part 'participator_api.g.dart';

@riverpod
ParticipatorLocalAPI participatorLocalAPI(
  ParticipatorLocalAPIRef ref,
) =>
    ParticipatorLocalAPI();

abstract class IParticipatorLocalAPI {
  Future<void> cacheParticipators({
    required List<ParticipatorModel> participatorsToCache,
  });
  Future<List<ParticipatorModel>> getLastParticipators();
}

class ParticipatorLocalAPI implements IParticipatorLocalAPI {
  ParticipatorLocalAPI();

  @override
  Future<List<ParticipatorModel>> getLastParticipators() {
    final jsonString = PreferenceUtils.getString(PrefConst.participatorData);
    if (jsonString.isEmpty) return Future.value(<ParticipatorModel>[]);
    final json = jsonDecode(jsonString) as List;

    return Future.value(
      json
          .map(
            (el) =>
                ParticipatorModel.fromJson(json: el as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  @override
  Future<void> cacheParticipators({
    required List<ParticipatorModel> participatorsToCache,
  }) async {
    if (participatorsToCache.isNotEmpty) {
      final participatorsToJson = participatorsToCache
          .map(
            (participatorToCache) => participatorToCache.toJson(),
          )
          .toList();

      await PreferenceUtils.setString(
        PrefConst.participatorData,
        json.encode(
          participatorsToJson,
        ),
      );
    } else {
      await PreferenceUtils.setString(
        PrefConst.participatorData,
        '',
      );
    }
  }
}

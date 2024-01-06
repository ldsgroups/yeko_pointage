import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yeko_pointage/apis/apis.dart';
import 'package:yeko_pointage/core/core.dart';
import 'package:yeko_pointage/models/models.dart';

part 'auth_controller.g.dart';

@riverpod
class TabletOwnerClass extends _$TabletOwnerClass {
  @override
  ClassModel? build() => null;

  void updateCurrentStore(ClassModel cls) => state = cls;
}

@riverpod
Future<bool> isAuthenticated(IsAuthenticatedRef ref) async {
  final authCtrl = ref.read(authControllerProvider.notifier);
  final me = await authCtrl.me();

  return me.fold(
    (l) => false,
    (r) {
      if (r != null && r.schoolId != null) {
        return true;
      }

      return false;
    },
  );
}

@riverpod
class ClassesData extends _$ClassesData {
  @override
  List<ClassModel> build() => [];

  Future<void> setStore(List<ClassModel> c) async => state = c;
}

@riverpod
class AuthController extends _$AuthController {
  @override
  bool build() => false;

  FutureEither<TokenModel?> signInWithUidAndPassword({
    required String uid,
    required String password,
  }) async {
    state = true;

    final authAPI = ref.read(authAPIProvider);
    final payload = await authAPI.signInWithUidAndPassword(
      uid: uid,
      password: password,
    );

    // if is right implement
    if (payload.isRight()) {
      final token = payload.getOrElse((r) => null);
      if (token != null) {
        await PreferenceUtils.setString(
          SharedPrefsConstants.token,
          token.token,
        );
        await PreferenceUtils.setString(
          SharedPrefsConstants.tokenExpiresAt,
          token.expiresAt.toIso8601String(),
        );
      }
    }

    state = false;
    return payload;
  }

  FutureEither<UserModel?> me() async {
    final authAPI = ref.read(userAPIProvider);
    final payload = await authAPI.me();

    return payload;
  }

  Future<SchoolModel?> getSchool({required String schoolId}) async {
    state = true;
    final schoolAPI = ref.read(schoolAPIProvider);
    final payload = await schoolAPI.getSchool(schoolId: schoolId);

    state = false;

    return payload.fold(
      (l) {
        return null;
      },
      (r) async {
        if (r != null) {
          await PreferenceUtils.setString(
            SharedPrefsConstants.schoolId,
            r.id,
          );

          await PreferenceUtils.setString(
            SharedPrefsConstants.schoolName,
            r.name,
          );
        }

        return r;
      },
    );
  }
}

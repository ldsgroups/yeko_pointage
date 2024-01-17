import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yeko_pointage/apis/apis.dart';
import 'package:yeko_pointage/core/core.dart';
import 'package:yeko_pointage/models/models.dart';

part 'auth_controller.g.dart';

@riverpod
class TabletOwnerClass extends _$TabletOwnerClass {
  @override
  ClassModel? build() => null;

  Future<void> updateCurrentStore(ClassModel cls) async => state = cls;
}

@riverpod
Future<IsAuthenticatedModel> isAuthenticated(IsAuthenticatedRef ref) async {
  final authCtrl = ref.read(authControllerProvider.notifier);
  final userId = await authCtrl.currentUserId();
  const authValue = IsAuthenticatedModel();

  if (userId == null) {
    return authValue;
  }

  final me = await authCtrl.me(userId: userId);

  return me.fold(
    (l) => authValue,
    (r) {
      if (r != null && r.schoolId != null) {
        return authValue.copyWith(
          isAuthenticated: true,
          isLinkedToASchool: true,
        );
      }

      return authValue.copyWith(
        isAuthenticated: true,
        isLinkedToASchool: false,
      );
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

  Future<String?> currentUserId() async {
    final currentUser = await ref.watch(authAPIProvider).currentUserId();

    return currentUser;
  }

  FutureEither<String?> signInWithUidAndPassword({
    required String uid,
    required String password,
  }) async {
    state = true;

    final authAPI = ref.read(authAPIProvider);
    final payload = await authAPI.signInWithUidAndPassword(
      email: uid,
      password: password,
    );

    state = false;
    return payload;
  }

  FutureEither<UserModel?> me({required String userId}) async {
    final authAPI = ref.read(userAPIProvider);
    final payload = await authAPI.me(userId: userId);

    return payload;
  }

  Future<void> signOut() async {
    await ref.read(authAPIProvider).signOut();
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
            PrefConst.schoolId,
            r.id,
          );

          await PreferenceUtils.setString(
            PrefConst.schoolName,
            r.name,
          );
        }

        return r;
      },
    );
  }
}

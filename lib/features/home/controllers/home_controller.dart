import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yeko_pointage/apis/apis.dart';
import 'package:yeko_pointage/core/core.dart';
import 'package:yeko_pointage/models/models.dart';

part 'home_controller.g.dart';

@riverpod
class IsAttendanceCheckingCompleted extends _$IsAttendanceCheckingCompleted {
  @override
  bool build() => false;

  Future<void> updateState({required bool b}) async {
    state = b;
  }
}

@riverpod
class IsParticipatorMode extends _$IsParticipatorMode {
  @override
  bool build() => false;

  Future<void> switchMode() async {
    state ? state = false : state = true;
  }
}

@riverpod
class ClassData extends _$ClassData {
  @override
  ClassModel build() => emptyClass;

  Future<void> updateClass(ClassModel cls) async => state = cls;
}

@riverpod
class AttendanceRecords extends _$AttendanceRecords {
  @override
  List<AttendanceModel> build() => [];

  Future<void> _updateState({
    required List<AttendanceModel> val,
    bool refresh = false,
  }) async {
    final homeCtrl = ref.read(homeControllerProvider.notifier);

    if (refresh) {
      final atd = await homeCtrl.getAttendances();
      state = atd;
    } else {
      await homeCtrl.setAttendances(attendances: val);
      final atd = await homeCtrl.getAttendances();
      state = atd;
    }
  }

  Future<void> refresh() async {
    await _updateState(val: [], refresh: true);
  }

  Future<void> _toggleAttendanceDuringChecking(
    AttendanceModel attendance,
  ) async {
    // find the attendance record of the student and it position in the list
    final attendanceRecord = state.firstWhere(
      (element) => element.studentId == attendance.studentId,
    );

    final attendanceRecordIndex = state.indexOf(attendanceRecord);

    // update the attendance record
    final updatedAttendanceRecord = attendanceRecord.copyWith(
      status: attendanceRecord.status == AttendanceStatus.present
          ? AttendanceStatus.absent
          : AttendanceStatus.present,
      statusLabelAndColor: getAttendanceColor(
        attendanceRecord.status == AttendanceStatus.present
            ? AttendanceStatus.absent
            : AttendanceStatus.present,
      ),
    );

    // update the attendance record in the list
    await _updateState(
      val: [
        ...state.sublist(0, attendanceRecordIndex),
        updatedAttendanceRecord,
        ...state.sublist(attendanceRecordIndex + 1),
      ],
    );
  }

  Future<void> _toggleAttendanceAfterChecking(
    AttendanceModel attendance,
  ) async {
    // return if student is present
    if (attendance.status == AttendanceStatus.present) return;

    // find the attendance record of the student and it position in the list
    final attendanceRecord = state.firstWhere(
      (element) => element.studentId == attendance.studentId,
    );

    final attendanceRecordIndex = state.indexOf(attendanceRecord);

    // update the attendance record
    final updatedAttendanceRecord = attendanceRecord.copyWith(
      status: attendanceRecord.status == AttendanceStatus.absent
          ? AttendanceStatus.late
          : AttendanceStatus.absent,
      statusLabelAndColor: getAttendanceColor(
        attendanceRecord.status == AttendanceStatus.absent
            ? AttendanceStatus.late
            : AttendanceStatus.absent,
      ),
    );

    // update the attendance record in the list
    await _updateState(
      val: [
        ...state.sublist(0, attendanceRecordIndex),
        updatedAttendanceRecord,
        ...state.sublist(attendanceRecordIndex + 1),
      ],
    );
  }

  Future<void> updateStudentAttendance(AttendanceModel attendance) async {
    final isAfterCompleted = ref.watch(isAttendanceCheckingCompletedProvider);

    isAfterCompleted
        ? await _toggleAttendanceAfterChecking(attendance)
        : await _toggleAttendanceDuringChecking(attendance);
  }

  Future<void> initializeAttendanceRecord() async {
    final homeCtrl = ref.read(homeControllerProvider.notifier);

    final currentClass = await homeCtrl.getClass();

    await _updateState(val: []);
    final atd = <AttendanceModel>[];

    for (final student in currentClass.students) {
      atd.add(
        AttendanceModel(
          studentId: student.id,
          studentName: student.fullName,
          status: AttendanceStatus.present,
          isExcused: false,
          date: DateTime.now(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );
    }

    await _updateState(val: atd);
  }
}

@riverpod
class ParticipatorRecords extends _$ParticipatorRecords {
  @override
  List<ParticipatorModel> build() => [];

  Future<void> _updateState({
    required List<ParticipatorModel> val,
    bool refresh = false,
  }) async {
    final homeCtrl = ref.read(homeControllerProvider.notifier);

    if (refresh) {
      final atd = await homeCtrl.getParticipators();
      state = atd;
    } else {
      await homeCtrl.setParticipators(participators: val);
      final atd = await homeCtrl.getParticipators();
      state = atd;
    }
  }

  Future<void> refresh() async {
    await _updateState(val: [], refresh: true);
  }

  Future<void> updateStudentParticipator({
    required int index,
    required ParticipatorModel data,
  }) async {
    // update the participator record
    if (index == -1) {
      await _updateState(
        val: [
          ...state,
          data,
        ],
      );
    } else {
      // remove the participator record from the list
      final newState = state.sublist(0, index) + state.sublist(index + 1);

      await _updateState(
        val: [
          ...newState,
        ],
      );
    }
  }
}

@riverpod
class HomeController extends _$HomeController {
  @override
  bool build() => false;

  Future<ClassModel> getClass() async {
    final classLocalAPI = ref.read(classLocalAPIProvider);
    final classDataCtrl = ref.read(classDataProvider.notifier);

    final response = await classLocalAPI.getLastClass();
    await classDataCtrl.updateClass(response);

    return response;
  }

  Future<List<AttendanceModel>> getAttendances() async {
    final attendanceLocalAPI = ref.read(attendanceLocalAPIProvider);

    final response = await attendanceLocalAPI.getLastAttendances();

    return response;
  }

  Future<void> setAttendances({
    required List<AttendanceModel> attendances,
  }) async {
    final attendanceLocalAPI = ref.read(attendanceLocalAPIProvider);

    await attendanceLocalAPI.cacheAttendances(attendancesToCache: attendances);
  }

  Future<List<ParticipatorModel>> getParticipators() async {
    final participatorLocalAPI = ref.read(participatorLocalAPIProvider);

    final response = await participatorLocalAPI.getLastParticipators();

    return response;
  }

  Future<void> setParticipators({
    required List<ParticipatorModel> participators,
  }) async {
    final participatorLocalAPI = ref.read(participatorLocalAPIProvider);

    await participatorLocalAPI.cacheParticipators(
      participatorsToCache: participators,
    );
  }

  FutureEither<String> createAttendanceAndParticipatorAndHomework({
    HomeworkModel? homework,
  }) async {
    state = true;

    final classAPI = ref.read(classAPIProvider);

    final attendanceList = ref.read(attendanceRecordsProvider);
    final participatorList = ref.read(participatorRecordsProvider);

    final notPresentStudents = attendanceList
        .where((e) => e.status != AttendanceStatus.present)
        .toList();

    final response = await classAPI.createAttendanceAndParticipatorAndHomework(
      attendances: notPresentStudents,
      participators: participatorList,
      homework: homework,
    );

    state = false;
    return response;
  }
}

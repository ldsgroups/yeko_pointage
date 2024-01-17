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
class ParticipationRecords extends _$ParticipationRecords {
  @override
  List<ParticipationModel> build() => [];

  Future<void> _updateState({
    required List<ParticipationModel> val,
    bool refresh = false,
  }) async {
    final homeCtrl = ref.read(homeControllerProvider.notifier);

    if (refresh) {
      final atd = await homeCtrl.getParticipations();
      state = atd;
    } else {
      await homeCtrl.setParticipations(participations: val);
      final atd = await homeCtrl.getParticipations();
      state = atd;
    }
  }

  Future<void> refresh() async {
    await _updateState(val: [], refresh: true);
  }

  Future<void> updateStudentParticipation(StudentModel student) async {
    const subjectId = '1';

    final participationRecord = state.firstWhere(
      (element) => element.studentId == student.id,
      orElse: () => ParticipationModel(
        studentId: student.id,
        subjectId: subjectId,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );

    final participationRecordIndex = state.indexOf(participationRecord);

    // update the participation record
    if (participationRecordIndex == -1) {
      await _updateState(
        val: [
          ...state,
          participationRecord,
        ],
      );
    } else {
      // remove the participation record from the list
      await _updateState(
        val: [
          ...state.sublist(0, participationRecordIndex),
          ...state.sublist(participationRecordIndex + 1),
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

  Future<List<ParticipationModel>> getParticipations() async {
    final participationLocalAPI = ref.read(participationLocalAPIProvider);

    final response = await participationLocalAPI.getLastParticipations();

    return response;
  }

  Future<void> setParticipations({
    required List<ParticipationModel> participations,
  }) async {
    final participationLocalAPI = ref.read(participationLocalAPIProvider);

    await participationLocalAPI.cacheParticipations(
      participationsToCache: participations,
    );
  }

  FutureEitherVoid createAttendanceAndParticipationAndHomework({
    HomeworkModel? homework,
  }) async {
    state = true;

    final classAPI = ref.read(classAPIProvider);

    final attendanceList = ref.read(attendanceRecordsProvider);
    final participationList = ref.read(participationRecordsProvider);

    final notPresentStudents = attendanceList
        .where((e) => e.status != AttendanceStatus.present)
        .toList();

    final response = await classAPI.createAttendanceAndParticipationAndHomework(
      attendances: notPresentStudents,
      participations: participationList,
      homework: homework,
    );

    state = false;
    return response;
  }
}

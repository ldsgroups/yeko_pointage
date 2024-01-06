// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yeko_pointage/apis/apis.dart';
import 'package:yeko_pointage/core/enums/enums.dart';
import 'package:yeko_pointage/models/models.dart';

part 'home_controller.g.dart';

@riverpod
class IsAttendanceCheckingCompleted extends _$IsAttendanceCheckingCompleted {
  @override
  bool build() => false;

  Future<void> updateState({required bool b}) async => state = b;
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

  AttendanceStatus _getNextAttendanceStatus(AttendanceStatus currentStatus) {
    switch (currentStatus) {
      case AttendanceStatus.present:
        return AttendanceStatus.absent;
      case AttendanceStatus.absent:
        return AttendanceStatus.late;
      case AttendanceStatus.late:
        return AttendanceStatus.present;
    }
  }

  Future<void> toggleAttendanceDuringChecking(String studentId) async {
    // find the attendance record of the student and it position in the list
    final attendanceRecord = state.firstWhere(
      (element) => element.studentId == studentId,
    );
    final attendanceRecordIndex = state.indexOf(attendanceRecord);

    // get the next attendance status
    final nextAttendanceStatus = _getNextAttendanceStatus(
      attendanceRecord.status,
    );

    // update the attendance record
    final updatedAttendanceRecord = attendanceRecord.copyWith(
      status: nextAttendanceStatus,
    );

    // update the attendance record in the list
    state[attendanceRecordIndex] = updatedAttendanceRecord;
  }

  Future<void> toggleAttendanceAfterChecking(String studentId) async {
    // find the attendance record of the student and it position in the list
    final attendanceRecord = state.firstWhere(
      (element) => element.studentId == studentId,
    );

    final attendanceRecordIndex = state.indexOf(attendanceRecord);

    // update the attendance record
    final updatedAttendanceRecord = attendanceRecord.copyWith(
      status: attendanceRecord.status == AttendanceStatus.absent
          ? AttendanceStatus.late
          : AttendanceStatus.absent,
    );

    // update the attendance record in the list
    state[attendanceRecordIndex] = updatedAttendanceRecord;
  }

  void updateStudentAttendance(StudentModel student) {
    final isAfterCompleted = ref.watch(isAttendanceCheckingCompletedProvider);

    isAfterCompleted
        ? toggleAttendanceAfterChecking(student.id)
        : toggleAttendanceDuringChecking(student.id);
  }

  Future<void> initializeAttendanceRecord(List<StudentModel> students) async {
    final attendanceRecords = ref.watch(attendanceRecordsProvider);
    attendanceRecords.clear();

    for (final student in students) {
      attendanceRecords.add(
        AttendanceModel(
          id: '',
          studentId: student.id,
          status: AttendanceStatus.present,
          date: DateTime.now(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );
    }
  }
}

@riverpod
class HomeController extends _$HomeController {
  @override
  bool build() => false;

  // List<AttendanceRecord> getAbsentAndLateStudents() {
  //   return attendanceRecords
  //       .where((record) => record.status != AttendanceStatus.present)
  //       .toList();
  // }

  Future<ClassModel> getClass() async {
    final prefs = await SharedPreferences.getInstance();
    final classLocalAPI = ref.read(classLocalAPIProvider(prefs));

    final classDataCtrl = ref.read(classDataProvider.notifier);

    final response = await classLocalAPI.getLastClass();
    await classDataCtrl.updateClass(response);

    return response;
  }
}

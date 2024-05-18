import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yeko_pointage/core/core.dart';
import 'package:yeko_pointage/features/home/controllers/home_controller.dart';
import 'package:yeko_pointage/models/models.dart';

class StudentListTile extends ConsumerWidget {
  const StudentListTile({
    super.key,
    required this.attendance,
    required this.isTablet,
  });

  final AttendanceModel attendance;
  final bool isTablet;

  String getAvatar(String val) {
    final words = val.split(' ');
    return words.first.substring(0, 1).toUpperCase();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final isParticipatorMode = ref.watch(isParticipatorModeProvider);
    final isCheckingOut = ref.watch(isAttendanceCheckingCompletedProvider);
    final participatorRec = ref.watch(participatorRecordsProvider);

    FindParticipatorIndexModel findStudentIndex() {
      const subjectId = '11b52518-fcbd-40a6-84cd-f51e3129eaaf';

      final participatorRecord = participatorRec.firstWhere(
        (element) => element.studentId == attendance.studentId,
        orElse: () => ParticipatorModel(
          studentId: attendance.studentId,
          subjectId: subjectId,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      return FindParticipatorIndexModel(
        index: participatorRec.indexOf(participatorRecord),
        data: participatorRecord,
      );
    }

    return ListTile(
      leading: CircleAvatar(
        child: Text(getAvatar(attendance.studentName)),
      ),
      title: Text(attendance.studentName),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Opacity(
          //   opacity: findStudentIndex().index != -1 ? 1 : 0.1,
          //   child: Icon(
          //     Icons.check_circle_outline_rounded,
          //     size: 20,
          //     color: findStudentIndex().index != -1
          //         ? Colors.green
          //         : Colors.grey.shade400,
          //   ),
          // ),
          GestureDetector(
            onTap: () async {
              await ref
                  .read(attendanceRecordsProvider.notifier)
                  .updateStudentAttendance(attendance);
            },
            child: Badge(
              label: Text(attendance.statusLabelAndColor!.label),
              textStyle: TextStyle(
                fontSize: isTablet ? 16 : 12,
                fontWeight: FontWeight.w500,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              largeSize: 20,
              backgroundColor: attendance.statusLabelAndColor!.color,
            ),
          ),
          if (isCheckingOut) const SizedBox(width: 5),
          if (isCheckingOut)
            Checkbox(
              value: findStudentIndex().index != -1,
              onChanged: (_) async {
                // we can't set the participator of an absent student
                if (attendance.status == AttendanceStatus.absent) {
                  AppUtils.showSnackBar(
                    context,
                    "Cet élève n'est pas présent au cours.",
                  );
                  return;
                }

                // max students length in participator mode is 5
                if (participatorRec.length >= 5 &&
                    findStudentIndex().index == -1) {
                  AppUtils.showSnackBar(
                    context,
                    'Oups, maximum 5 élèves.',
                  );
                  return;
                }

                await ref
                    .read(participatorRecordsProvider.notifier)
                    .updateStudentParticipator(
                      index: findStudentIndex().index,
                      data: findStudentIndex().data,
                    );
              },
            ),
        ],
      ),
      // onLongPress: () async {
      //   if (isParticipatorMode) {
      //     // we can't set the participator of an absent student
      //     if (attendance.status == AttendanceStatus.absent) {
      //       AppUtils.showSnackBar(
      //         context,
      //         "Cet élève n'est pas présent au cours.",
      //       );
      //       return;
      //     }

      //     // max students length in participator mode is 5
      //     if (participatorRec.length >= 5 && findStudentIndex().index == -1) {
      //       AppUtils.showSnackBar(
      //         context,
      //         'Oups, maximum 5 élèves.',
      //       );
      //       return;
      //     }

      //     await ref
      //         .read(participatorRecordsProvider.notifier)
      //         .updateStudentParticipator(
      //           index: findStudentIndex().index,
      //           data: findStudentIndex().data,
      //         );
      //   } else {
      //     await ref
      //         .read(attendanceRecordsProvider.notifier)
      //         .updateStudentAttendance(attendance);
      //   }
      // },
    );
  }
}

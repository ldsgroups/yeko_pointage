import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
    return ListTile(
      leading: CircleAvatar(
        child: Text(getAvatar(attendance.studentName)),
      ),
      title: Text(attendance.studentName),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.check_circle_outline_rounded,
            size: 20,
            color: Colors.green,
          ),
          const SizedBox(width: 5),
          Badge(
            label: Text(attendance.statusLabelAndColor!.label),
            textStyle: TextStyle(
              fontSize: isTablet ? 16 : 12,
              fontWeight: FontWeight.w500,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            largeSize: 20,
            backgroundColor: attendance.statusLabelAndColor!.color,
          ),
        ],
      ),
      onLongPress: () async {
        await ref
            .read(attendanceRecordsProvider.notifier)
            .updateStudentAttendance(attendance);
      },
    );
  }
}

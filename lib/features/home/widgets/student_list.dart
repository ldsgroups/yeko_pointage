import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:yeko_pointage/core/core.dart';
import 'package:yeko_pointage/models/models.dart';

class StudentList extends StatelessWidget {
  const StudentList({super.key, required this.students, this.isTablet = true});

  final List<StudentModel> students;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    final attendanceList = <AttendanceModel>[];

    AttendanceColorModel attendanceColor(String studentId) {
      final r = attendanceList.filter((t) => t.studentId == studentId).toList();

      return getAttendanceColor(r);
    }

    String getAvatar(String val) {
      final words = val.split(' ');
      return words.first.substring(0, 1).toUpperCase();
    }

    return Expanded(
      flex: 3,
      child: GroupedListView(
        elements: students,
        useStickyGroupSeparators: true,
        physics: const BouncingScrollPhysics(),
        groupSeparatorBuilder: (value) => Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              value.substring(0, 1),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        groupBy: (el) => el.fullName.substring(0, 1),
        itemBuilder: (context, el) {
          final atd = attendanceColor(el.id);
          return ListTile(
            leading: CircleAvatar(
              child: Text(getAvatar(el.fullName)),
            ),
            title: Text(el.fullName),
            trailing: Badge(
              label: Text(atd.label),
              textStyle: TextStyle(
                fontSize: isTablet ? 16 : 12,
                fontWeight: FontWeight.w500,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              largeSize: 20,
              backgroundColor: atd.color,
            ),
            onLongPress: () {
              print('LongPress');
            },
          );
        },
      ),
    );
  }
}

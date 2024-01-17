import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yeko_pointage/features/home/controllers/home_controller.dart';
import 'package:yeko_pointage/features/home/widgets/student_listtile.dart';

class StudentList extends ConsumerWidget {
  const StudentList({super.key, this.isTablet = true});
  final bool isTablet;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attendanceList = ref.watch(attendanceRecordsProvider);

    print(
      '=====| RES |===== ${attendanceList.map((e) => e.status.name).toList()}',
    );

    return Expanded(
      flex: 3,
      child: GroupedListView(
        elements: attendanceList,
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
        groupBy: (el) => el.studentName.substring(0, 1),
        itemBuilder: (context, el) => StudentListTile(
          isTablet: isTablet,
          attendance: el,
        ),
      ),
    );
  }
}

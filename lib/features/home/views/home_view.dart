import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yeko_pointage/commons/commons.dart';
import 'package:yeko_pointage/core/core.dart';
import 'package:yeko_pointage/features/home/controllers/home_controller.dart';
import 'package:yeko_pointage/features/home/widgets/widgets.dart';
import 'package:yeko_pointage/models/models.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  static MaterialPageRoute<HomePage> route() => MaterialPageRoute<HomePage>(
        builder: (context) => const HomePage(),
      );

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final schoolId = PreferenceUtils.getString(PrefConst.schoolId);
  final schoolName = PreferenceUtils.getString(PrefConst.schoolName);

  @override
  void initState() {
    initializeClassData();
    super.initState();
  }

  Future<ClassModel> initializeClassData() async {
    final c = await ref.read(homeControllerProvider.notifier).getClass();

    await ref
        .read(attendanceRecordsProvider.notifier)
        .initializeAttendanceRecord();

    return c;
  }

  @override
  Widget build(BuildContext context) {
    final currentClass = ref.watch(classDataProvider);

    // Variables
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              currentClass.name,
              style: textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            rowDivider,
            Expanded(
              child: Text(schoolName, style: textTheme.titleLarge),
            ),
          ],
        ),
        actions: const [
          Icon(Icons.logout),
          rowDivider,
        ],
      ),
      body: isTablet
          ? TabletPage(
              className: currentClass.name,
              schoolName: schoolName,
              students: currentClass.students,
            )
          : const PhonePage(),
    );
  }
}

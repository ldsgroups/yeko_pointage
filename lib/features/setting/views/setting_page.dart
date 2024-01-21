import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yeko_pointage/core/core.dart';
import 'package:yeko_pointage/features/auth/auth.dart';
import 'package:yeko_pointage/features/setting/controllers/setting_controller.dart';
import 'package:yeko_pointage/models/models.dart';

class SettingPage extends StatefulHookConsumerWidget {
  const SettingPage({super.key, required this.school});

  static MaterialPageRoute<SettingPage> route({required SchoolModel school}) {
    return MaterialPageRoute(
      builder: (context) => SettingPage(school: school),
    );
  }

  final SchoolModel school;

  @override
  ConsumerState<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends ConsumerState<SettingPage> {
  @override
  void initState() {
    handleGetSchoolClasses();
    super.initState();
  }

  Future<void> handleGetSchoolClasses() async {
    final settingCtrl = ref.read(settingControllerProvider.notifier);
    await settingCtrl.getClasses(schoolId: widget.school.id);
  }

  @override
  Widget build(BuildContext context) {
    final classesList = ref.watch(classesDataProvider);

    final scrollController = ScrollController();
    final selectedGrade = useState<String>('');
    final selectedClass = useState<String>('');

    final isPrimary = widget.school.cycleId == 'primary';
    final grades = isPrimary
        ? EducationalLevels.primaryGrades
        : EducationalLevels.secondaryGrades;

    // TODO: Redesign tablet view
    // final size = MediaQuery.of(context).size;
    // final isTablet = size.width > size.height;

    Future<void> setTabletOwner() async {
      if (selectedClass.value.isEmpty) {
        AppUtils.showSnackBar(context, 'Veillez sélectionner une classe');
        return;
      }
      final settingCtrl = ref.read(settingControllerProvider.notifier);

      final res = await settingCtrl.setOwnerToTablet(
        schoolId: widget.school.id,
        classId: selectedClass.value,
      );

      if (res != null && res.id.isNotEmpty) {
        if (context.mounted) {
          await AppUtils.infoDialog(
            context: context,
            text: 'Super, cette tablette appartient désormais à la ${res.name}',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                ScanPage.route(),
                (route) => false,
              );
            },
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.school.name),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: grades.length,
                itemBuilder: (context, index) {
                  final grade = grades[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ChoiceChip(
                      label: Text(grade),
                      selected: selectedGrade.value == grade,
                      onSelected: (selected) {
                        selectedGrade.value = grade;

                        // scroll to new position
                        scrollController.animateTo(
                          index * 33.0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.bounceOut,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: classesList.length,
                itemBuilder: (context, index) {
                  final oneClass = classesList[index];

                  return ListTile(
                    onTap: () => selectedClass.value = oneClass.id,
                    title: Text(oneClass.name),
                    subtitle: const Text(' M. Dramane Kader'),
                    trailing: selectedClass.value == oneClass.id
                        ? const Icon(Icons.check, color: Colors.green)
                        : null,
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: setTabletOwner,
                  child: const Text('Sauvegarder'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

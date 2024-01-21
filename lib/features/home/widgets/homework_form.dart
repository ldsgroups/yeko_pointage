import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yeko_pointage/commons/commons.dart';
import 'package:yeko_pointage/core/core.dart';
import 'package:yeko_pointage/features/auth/auth.dart';
import 'package:yeko_pointage/features/home/controllers/home_controller.dart';
import 'package:yeko_pointage/models/homework_model.dart';

class HomeworkForm extends HookConsumerWidget {
  const HomeworkForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final selectedDate = useState<DateTime?>(null);
    final itWillBeANote = useState<bool>(false);

    final today = DateTime.now();

    Future<void> handleCloseSession() async {
      // show scaffold messenger if selectedDate is null
      if (selectedDate.value == null) {
        AppUtils.showSnackBar(
          context,
          'Veillez sélectionner la date de ramassage',
        );

        return;
      }

      final homework = HomeworkModel(
        classId: PreferenceUtils.getString(PrefConst.classId),
        subjectId: '11b52518-fcbd-40a6-84cd-f51e3129eaaf',
        dueDate: selectedDate.value ?? today,
        itWillBeANote: itWillBeANote.value,
        createdAt: today,
        updatedAt: today,
      );

      await ref
          .read(homeControllerProvider.notifier)
          .createAttendanceAndParticipatorAndHomework(homework: homework);

      await PreferenceUtils.removeKeys([
        PrefConst.attendanceData,
        PrefConst.participatorData,
      ]);

      if (!context.mounted) return;
      final ctx = Navigator.of(context).context;
      Navigator.of(context).pop();

      return AppUtils.infoDialog(
        context: ctx,
        text: 'M. Soro, merci pour le cours dispensé',
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            ctx,
            ScanPage.route(),
            (route) => false,
          );
        },
      );
    }

    return Dialog(
      insetAnimationDuration: const Duration(
        milliseconds: 300,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            smallColDivider,
            Text(
              'Exercise de maison',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            largeColDivider,
            SwitchListTile(
              title: const Text('Est-ce à ramasser ?'),
              value: itWillBeANote.value,
              onChanged: (val) => itWillBeANote.value = val,
            ),
            GestureDetector(
              onTap: () => AppUtils.selectDate(
                initialDate: selectedDate.value,
                firstDate: today,
                lastDate: today.add(const Duration(days: 14)),
                context: context,
                onDateSelected: (value) {
                  selectedDate.value = value;
                },
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('À rendre le'),
                    smallRowDivider,
                    Chip(
                      label: Text(
                        selectedDate.value == null
                            ? 'Non spécifier'
                            : AppUtils.formatDate(
                                selectedDate.value,
                                DateFormatType.long,
                              ),
                      ),
                      avatar: const Icon(Icons.calendar_month),
                    ),
                    const SizedBox(width: 1),
                  ],
                ),
              ),
            ),
            largeColDivider,
            const Divider(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.58,
              child: CustomMaterialButton(
                text: 'Assigner et clore',
                onPressed: handleCloseSession,
              ),
            ),
            smallColDivider,
          ],
        ),
      ),
    );
  }
}

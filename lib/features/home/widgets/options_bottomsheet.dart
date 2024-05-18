import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yeko_pointage/commons/custom_material_button.dart';
import 'package:yeko_pointage/core/enums/enums.dart';
import 'package:yeko_pointage/core/utils/utils.dart';
import 'package:yeko_pointage/models/models.dart';

Future<dynamic> optionsBottomSheet({
  required BuildContext context,
  required WidgetRef ref,
  required List<AttendanceModel> attendanceList,
  required int participatorLen,
  required void Function({bool? setHomework}) onAction,
}) {
  int attendanceStatusLen(AttendanceStatus status) {
    return attendanceList
        .where(
          (e) => e.status == status,
        )
        .length;
  }

  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          const Text(
            'Que voulez-vous faire ?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          ListTile(
            trailing: Text(
              attendanceStatusLen(AttendanceStatus.absent).toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: const Text('Absents'),
          ),
          ListTile(
            trailing: Text(
              attendanceStatusLen(AttendanceStatus.late).toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: const Text('Retards'),
          ),
          // const CsAttendanceParticipatorSwitcher(),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 8,
            ),
            child: CustomMaterialButton(
              text: 'Clôturer la session',
              onPressed: () async {
                if (participatorLen == 0) {
                  Navigator.of(context).pop();

                  AppUtils.showSnackBar(
                    context,
                    "Veillez d'abord attribuer la participator à au moins un élève",
                  );
                  return;
                }

                Navigator.of(context).pop();

                // show a yes/no dialog to ask the teacher if it was give a homework.
                if (context.mounted) {
                  return AppUtils.yesOrNoModal(
                    context: context,
                    onConfirm: () => onAction(setHomework: true),
                    onCancel: onAction,
                  );
                }
              },
            ),
          ),
        ],
      );
    },
  );
}

// class CsAttendanceParticipatorSwitcher extends ConsumerWidget {
//   const CsAttendanceParticipatorSwitcher({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final isParticipatorMode = ref.watch(isParticipatorModeProvider);

//     return SwitchListTile(
//       selected: isParticipatorMode,
//       activeColor: Colors.green,
//       title: Text(
//         isParticipatorMode ? 'Mode Participator' : 'Mode Appel',
//       ),
//       value: isParticipatorMode,
//       onChanged: (_) {
//         ref.read(isParticipatorModeProvider.notifier).switchMode();
//       },
//     );
//   }
// }

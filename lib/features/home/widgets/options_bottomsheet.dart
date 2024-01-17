import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yeko_pointage/core/enums/enums.dart';
import 'package:yeko_pointage/core/utils/utils.dart';
import 'package:yeko_pointage/models/models.dart';

Future<void> optionsBottomSheet(
  BuildContext context,
  List<AttendanceModel> attendanceList,
  WidgetRef ref,
) {
  Future<void> handleClose() async {
    final notPresentStudents = attendanceList
        .where((e) => e.status != AttendanceStatus.present)
        .toList();

    // update the remote database

    // close dialog
    Navigator.of(context).pop();

    // navigate to scan page
    // await Navigator.pushAndRemoveUntil(context, ScanPage.route(), (route) => false);
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
              '${attendanceList.where((e) => e.status == AttendanceStatus.absent).length}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: const Text('Absents'),
          ),
          ListTile(
            trailing: Text(
              '${attendanceList.where((e) => e.status == AttendanceStatus.late).length}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: const Text('Retards'),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 8,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Theme.of(context).colorScheme.secondary,
                foregroundColor: Theme.of(context).colorScheme.onSecondary,
              ),
              onPressed: () async {
                Navigator.of(context).pop();

                // show a yes/no dialog to ask the teacher if it was give a homework.
                return AppUtils.yesOrNoModal(
                  context: context,
                  onConfirm: () async {
                    // close the session.
                    await handleClose();
                  },
                  onCancel: handleClose,
                );
              },
              child: const Text(
                'Terminer la session',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yeko_pointage/commons/commons.dart';
import 'package:yeko_pointage/core/core.dart';
import 'package:yeko_pointage/features/auth/auth.dart';
import 'package:yeko_pointage/features/home/controllers/home_controller.dart';
import 'package:yeko_pointage/features/home/widgets/widgets.dart';

class PhonePage extends HookConsumerWidget {
  const PhonePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();

    final isCheckingOut = ref.watch(isAttendanceCheckingCompletedProvider);

    Future<void> handleCloseSession({bool? setHomework = false}) async {
      if (setHomework!) {
        Navigator.of(context).pop();
        return showDialog(
          context: context,
          builder: (context) {
            return const HomeworkForm();
          },
        );
      }

      final payload = await ref
          .read(homeControllerProvider.notifier)
          .createAttendanceAndParticipatorAndHomework();

      await payload.fold(
        (l) {
          AppUtils.showSnackBar(context, l.errorMessage);
        },
        (r) async {
          await PreferenceUtils.removeKeys([
            PrefConst.attendanceData,
            PrefConst.participatorData,
          ]);

          if (context.mounted) {
            await AppUtils.infoDialog(
              context: context,
              text: 'M. Thibault, merci pour le cours dispensé',
              child: ColoredBox(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Text(
                  '12:32',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil(
                  context,
                  ScanPage.route(),
                  (route) => false,
                );
              },
            );
          }
        },
      );
    }

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.8,
            child: DataTable(
              columns: const [
                DataColumn(label: SizedBox()),
                DataColumn(label: SizedBox()),
              ],
              rows: [
                buildDataRow(label: 'Effectif', value: '45'),
                buildDataRow(label: 'Heure', value: '10h45'),
              ],
            ),
          ),
          colDivider,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SearchBar(
              elevation: const WidgetStatePropertyAll<double>(1),
              controller: searchController,
              hintText: 'Rechercher par matricule ou nom',
              leading: const Icon(Icons.search),
              padding: const WidgetStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              ),
              shape: const WidgetStatePropertyAll<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ),
          ),
          colDivider,
          const StudentList(isTablet: false),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: CustomMaterialButton(
          isInverted: isCheckingOut && false,
          text: isCheckingOut ? 'Options' : "Fin d'appel",
          onPressed: () async {
            if (isCheckingOut) {
              await optionsBottomSheet(
                context: context,
                ref: ref,
                attendanceList: ref.read(attendanceRecordsProvider),
                participatorLen: ref.read(participatorRecordsProvider).length,
                onAction: handleCloseSession,
              );
            } else {
              await ref
                  .read(isAttendanceCheckingCompletedProvider.notifier)
                  .updateState(b: true);

              await ref.read(attendanceRecordsProvider.notifier).refresh();
            }
          },
        ),
      ),
    );
  }

  DataRow buildDataRow({required String label, required String value}) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        DataCell(Text(': $value')),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yeko_pointage/commons/commons.dart';
import 'package:yeko_pointage/features/home/controllers/home_controller.dart';
import 'package:yeko_pointage/features/home/widgets/widgets.dart';

class PhonePage extends HookConsumerWidget {
  const PhonePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();

    final attendanceList = ref.watch(attendanceRecordsProvider);
    final isCheckingOut = ref.watch(isAttendanceCheckingCompletedProvider);

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SearchBar(
              elevation: const MaterialStatePropertyAll<double>(1),
              controller: searchController,
              hintText: 'Rechercher par matricule ou nom',
              leading: const Icon(Icons.search),
              padding: const MaterialStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              ),
              shape: const MaterialStatePropertyAll<RoundedRectangleBorder>(
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
            if (isCheckingOut) {
              return optionsBottomSheet(context, attendanceList, ref);
            } else {
              final atdCtrl = ref.read(attendanceRecordsProvider.notifier);

              await ref
                  .read(isAttendanceCheckingCompletedProvider.notifier)
                  .updateState(b: true);

              await atdCtrl.refresh();
            }
          },
          child: Text(
            isCheckingOut ? 'Options' : "Terminer l'appel",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}

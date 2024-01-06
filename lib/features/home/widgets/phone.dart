import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yeko_pointage/commons/commons.dart';
import 'package:yeko_pointage/features/home/controllers/home_controller.dart';
import 'package:yeko_pointage/features/home/widgets/student_list.dart';
import 'package:yeko_pointage/models/models.dart';

class PhonePage extends HookConsumerWidget {
  const PhonePage({super.key, required this.students});

  final List<StudentModel> students;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final currentClass = ref.watch(classDataProvider.notifier);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SearchBar(
              elevation: const MaterialStatePropertyAll<double>(1),
              controller: searchController,
              hintText: 'Rechercher par matricule ou nom',
              leading: const Icon(Icons.search),
              padding: const MaterialStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
            colDivider,
            StudentList(students: currentClass.state.students, isTablet: false),
          ],
        ),
      ),
    );
  }
}

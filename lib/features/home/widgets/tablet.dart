import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yeko_pointage/commons/divider.dart';
import 'package:yeko_pointage/features/home/widgets/student_list.dart';
import 'package:yeko_pointage/models/models.dart';

class TabletPage extends HookConsumerWidget {
  const TabletPage({
    super.key,
    required this.students,
    required this.schoolName,
    required this.className,
  });

  final String schoolName;
  final String className;
  final List<StudentModel> students;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Variables
    final searchController = useTextEditingController();
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        width: size.width,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(schoolName, style: textTheme.titleLarge),
                  Text(className, style: textTheme.headlineMedium),
                  colDivider,
                  const Card(
                    child: Column(
                      children: [
                        Text('Effectif de la classe'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
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
                    const StudentList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yeko_pointage/commons/commons.dart';

enum EAttendanceType { present, absent, retard }

class IGrade {
  const IGrade({
    required this.id,
    required this.name,
    required this.effectif,
  });

  final int id;
  final String name;
  final int effectif;
}

class ISchool {
  const ISchool({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
  });

  final int id;
  final String name;
  final String address;
  final String phone;
}

class ITeacher {
  const ITeacher({
    required this.id,
    required this.schoolId,
    required this.name,
    required this.firstName,
  });

  final int id;
  final int schoolId;
  final String name;
  final String firstName;
}

class IStudent {
  const IStudent({
    required this.id,
    required this.gradeId,
    required this.schoolId,
    required this.name,
    required this.firstName,
  });

  final int id;
  final int gradeId;
  final int schoolId;
  final String name;
  final String firstName;
}

class IAttendance {
  const IAttendance({
    required this.id,
    required this.teacherId,
    required this.studentId,
    required this.date,
    required this.time,
    required this.type,
  });

  final int id;
  final int teacherId;
  final int studentId;
  final DateTime date;
  final String time;
  final EAttendanceType type;
}

List<IGrade> listOfGrades = [
  const IGrade(id: 1, name: '6è', effectif: 60),
  const IGrade(id: 2, name: '3è', effectif: 40),
  const IGrade(id: 2, name: '2nd C', effectif: 40),
  const IGrade(id: 1, name: 'Tle A', effectif: 30),
  const IGrade(id: 1, name: 'Tle D', effectif: 20),
];

List<ISchool> listOfSchools = [
  const ISchool(
    id: 1,
    name: "Lycée Technique d'Abidjan",
    address: 'Cocody',
    phone: '0505050505',
  ),
  const ISchool(
    id: 2,
    name: "Collège Moderne d'Abidjan",
    address: 'Plateau',
    phone: '0707070707',
  ),
];

List<ITeacher> listOfTeachers = [
  const ITeacher(id: 1, schoolId: 1, name: 'Prof.', firstName: 'de Français'),
  const ITeacher(id: 2, schoolId: 1, name: 'Prof.', firstName: 'de Anglais'),
  const ITeacher(id: 3, schoolId: 2, name: 'Prof.', firstName: 'de Maths'),
];

List<IStudent> listOfStudents = [
  const IStudent(
    id: 1,
    gradeId: 2,
    schoolId: 1,
    name: 'Amiral',
    firstName: 'Bamba',
  ),
  const IStudent(
    id: 2,
    gradeId: 2,
    schoolId: 1,
    name: 'Apo',
    firstName: 'Gilbert',
  ),
  const IStudent(
    id: 3,
    gradeId: 2,
    schoolId: 1,
    name: 'Cissé',
    firstName: 'Fanta',
  ),
  const IStudent(
    id: 4,
    gradeId: 2,
    schoolId: 1,
    name: 'Coulibaly',
    firstName: 'Yaya',
  ),
  const IStudent(
    id: 5,
    gradeId: 2,
    schoolId: 1,
    name: 'Fofana',
    firstName: 'Bintou',
  ),
  const IStudent(
    id: 6,
    gradeId: 2,
    schoolId: 1,
    name: 'Kassi',
    firstName: 'Darius',
  ),
  const IStudent(
    id: 7,
    gradeId: 2,
    schoolId: 1,
    name: 'Kouassi',
    firstName: 'Leevy',
  ),
  const IStudent(
    id: 8,
    gradeId: 2,
    schoolId: 1,
    name: 'Kaboré',
    firstName: 'Charlemagne',
  ),
  const IStudent(
    id: 9,
    gradeId: 2,
    schoolId: 1,
    name: 'Manadja',
    firstName: 'Confirmé',
  ),
  const IStudent(
    id: 10,
    gradeId: 2,
    schoolId: 1,
    name: 'Roland',
    firstName: 'Le Beau',
  ),
];

List<IAttendance> listOfAttendances = [
  IAttendance(
    id: 1,
    teacherId: 1,
    studentId: 1,
    date: DateTime.now(),
    time: DateTime.now().toIso8601String(),
    type: EAttendanceType.present,
  ),
  IAttendance(
    id: 2,
    teacherId: 1,
    studentId: 2,
    date: DateTime.now(),
    time: DateTime.now().toIso8601String(),
    type: EAttendanceType.present,
  ),
  IAttendance(
    id: 3,
    teacherId: 1,
    studentId: 3,
    date: DateTime.now(),
    time: DateTime.now().toIso8601String(),
    type: EAttendanceType.present,
  ),
  IAttendance(
    id: 4,
    teacherId: 1,
    studentId: 4,
    date: DateTime.now(),
    time: DateTime.now().toIso8601String(),
    type: EAttendanceType.present,
  ),
  IAttendance(
    id: 5,
    teacherId: 1,
    studentId: 5,
    date: DateTime.now(),
    time: DateTime.now().toIso8601String(),
    type: EAttendanceType.absent,
  ),
  IAttendance(
    id: 6,
    teacherId: 1,
    studentId: 6,
    date: DateTime.now(),
    time: DateTime.now().toIso8601String(),
    type: EAttendanceType.retard,
  ),
  IAttendance(
    id: 7,
    teacherId: 1,
    studentId: 7,
    date: DateTime.now(),
    time: DateTime.now().toIso8601String(),
    type: EAttendanceType.present,
  ),
  IAttendance(
    id: 8,
    teacherId: 1,
    studentId: 8,
    date: DateTime.now(),
    time: DateTime.now().toIso8601String(),
    type: EAttendanceType.present,
  ),
  IAttendance(
    id: 9,
    teacherId: 1,
    studentId: 9,
    date: DateTime.now(),
    time: DateTime.now().toIso8601String(),
    type: EAttendanceType.absent,
  ),
  IAttendance(
    id: 10,
    teacherId: 1,
    studentId: 10,
    date: DateTime.now(),
    time: DateTime.now().toIso8601String(),
    type: EAttendanceType.present,
  ),
];

class BadgeOptions {
  const BadgeOptions({required this.label, required this.color});

  final String label;
  final Color color;
}

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const radioGroup = 'attendanceGroup';
    final selectedStudent = useState<IStudent?>(null);
    final selectedAttend = useState<EAttendanceType>(EAttendanceType.present);

    IAttendance getAttendance(int studentId) {
      return listOfAttendances.filter((e) {
        return e.studentId == studentId;
      }).first;
    }

    void handleSelectStudent(IStudent? student) {
      selectedStudent.value = student;
      if (student != null) {
        final attendance = getAttendance(student.id);
        selectedAttend.value = attendance.type;
      }
    }

    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    BadgeOptions getAttendanceColor(int studentId) {
      final attendance = getAttendance(studentId);

      final attendanceType = attendance.type;

      return attendanceType == EAttendanceType.present
          ? const BadgeOptions(
              label: 'Présent',
              color: Colors.green,
            )
          : attendanceType == EAttendanceType.retard
              ? const BadgeOptions(
                  label: 'Retard',
                  color: Colors.orange,
                )
              : const BadgeOptions(
                  label: 'Absent',
                  color: Colors.red,
                );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: Text(
          'Lycée Municipal de Koumassi',
          style: textTheme.titleLarge,
        ),
        actions: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                colorScheme.primary,
              ),
              foregroundColor: MaterialStateProperty.all(
                colorScheme.onPrimary,
              ),
            ),
            onPressed: () {},
            child: const Text('Clotûrer la session'),
          ),
          rowDivider,
        ],
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.sizeOf(context).width,
          minHeight: MediaQuery.sizeOf(context).height,
        ),
        child: Padding(
          padding: const EdgeInsets.all(72),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Card(
                  child: ListView.builder(
                    itemCount: listOfStudents.length,
                    itemBuilder: (context, index) {
                      final student = listOfStudents[index];
                      final badge = getAttendanceColor(student.id);

                      return ListTile(
                        title: Text('${student.name} ${student.firstName}'),
                        trailing: Badge(
                          label: Text(
                            badge.label,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          largeSize: 20,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          backgroundColor: badge.color,
                        ),
                        onTap: () => handleSelectStudent(student),
                      );
                    },
                  ),
                ),
              ),
              rowDivider,
              Expanded(
                flex: 3,
                child: selectedStudent.value != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                '${selectedStudent.value!.name} ${selectedStudent.value!.firstName}',
                                style: textTheme.headlineMedium,
                              ),
                              largeColDivider,
                              Card(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RadioMenuButton(
                                      value: EAttendanceType.present,
                                      groupValue: 1,
                                      onChanged: (_) {
                                        selectedAttend.value =
                                            EAttendanceType.present;
                                      },
                                      child: const Text('Présent'),
                                    ),
                                    RadioMenuButton(
                                      value: EAttendanceType.absent,
                                      groupValue: 1,
                                      onChanged: (_) {
                                        selectedAttend.value =
                                            EAttendanceType.absent;
                                      },
                                      child: const Text('Absent'),
                                    ),
                                  ],
                                ),
                              ),
                              Text(selectedAttend.value.name),
                            ],
                          ),
                          CustomMaterialButton(
                            text: "Fin de l'appel",
                            isInverted: true,
                            onPressed: () {},
                          ),
                        ],
                      )
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

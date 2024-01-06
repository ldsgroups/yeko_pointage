import 'package:yeko_pointage/core/enums/enums.dart';

class NoParams {}

class TemplateParams {
  const TemplateParams({this.template});

  final String? template;
}

class SignInParams {
  const SignInParams({required this.email, required this.password});

  final String email;
  final String password;
}

class StudentParams {
  const StudentParams({this.id, this.idNumber});

  final String? id;
  final String? idNumber;
}

class AttendanceParams {
  const AttendanceParams({this.id, this.studentId, this.type, this.date});

  final String? id;
  final String? studentId;
  final AttendanceStatus? type;
  final DateTime? date;
}

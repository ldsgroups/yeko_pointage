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

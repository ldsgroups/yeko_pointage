import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yeko_pointage/features/auth/presentation/pages/sign_in_page.dart';
import 'package:yeko_pointage/themes/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: CoreApp()));
}

class CoreApp extends StatelessWidget {
  const CoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yeko Pointage',
      theme: lightTheme(),
      darkTheme: darkTheme(),
      restorationScopeId: 'app',
      home: const SignInPage(),
    );
  }
}

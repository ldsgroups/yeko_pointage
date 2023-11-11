import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yeko_pointage/core/constants/constants.dart';
import 'package:yeko_pointage/features/home_page.dart';
import 'package:yeko_pointage/themes/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SupabaseConstants.endPoint,
    anonKey: SupabaseConstants.projectId,
  );

  runApp(const ProviderScope(child: CoreApp()));
}

class CoreApp extends StatelessWidget {
  const CoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: lightTheme(),
      darkTheme: darkTheme(),
      restorationScopeId: 'app',
      home: const HomePage(),
    );
  }
}

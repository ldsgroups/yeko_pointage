import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yeko_pointage/commons/commons.dart';
import 'package:yeko_pointage/core/constants/constants.dart';
import 'package:yeko_pointage/features/auth/presentation/presentation.dart';
import 'package:yeko_pointage/themes/themes.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Supabase.initialize(
    url: SupabaseConstants.endPoint,
    anonKey: SupabaseConstants.projectId,
  );

  runApp(const ProviderScope(child: CoreApp()));
}

class CoreApp extends ConsumerWidget {
  const CoreApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(isAuthenticatedProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: lightTheme(),
      darkTheme: darkTheme(),
      restorationScopeId: 'app',
      home: authState.when(
        error: (error, stackTrace) {
          FlutterNativeSplash.remove();
          return ErrorPage(error: error.toString());
        },
        loading: () => const LoadingPage(),
        data: (user) {
          FlutterNativeSplash.remove();
          if (user != null) {
            return const LockingPage();
          }
          return const SignInPage();
        },
      ),
    );
  }
}

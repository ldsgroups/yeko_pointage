import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yeko_pointage/commons/commons.dart';
import 'package:yeko_pointage/core/core.dart';
import 'package:yeko_pointage/features/auth/auth.dart';
import 'package:yeko_pointage/features/auth/controllers/auth_controller.dart';
import 'package:yeko_pointage/themes/themes.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await PreferenceUtils.init();

  runApp(const ProviderScope(child: CoreApp()));
}

class CoreApp extends ConsumerWidget {
  const CoreApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    final authState = ref.watch(isAuthenticatedProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appDisplayName,
      theme: lightTheme(),
      darkTheme: darkTheme(),
      restorationScopeId: 'app',
      home: authState.when(
        error: (error, stackTrace) {
          FlutterNativeSplash.remove();
          return ErrorPage(error: error.toString());
        },
        loading: () => const LoadingPage(),
        data: (isAuthorized) {
          FlutterNativeSplash.remove();
          if (isAuthorized) {
            return const ScanPage();
          }
          return const SignInPage();
        },
      ),
    );
  }
}

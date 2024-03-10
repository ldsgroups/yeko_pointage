import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yeko_pointage/commons/commons.dart';
import 'package:yeko_pointage/core/core.dart';
import 'package:yeko_pointage/features/auth/auth.dart';
import 'package:yeko_pointage/features/auth/controllers/auth_controller.dart';
import 'package:yeko_pointage/l10n/l10n.dart';
import 'package:yeko_pointage/themes/themes.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await initializeDateFormatting();

  await Supabase.initialize(
    url: SupabaseConstants.endPoint,
    anonKey: SupabaseConstants.projectId,
  );

  await PreferenceUtils.init();

  runApp(const ProviderScope(child: CoreApp()));
}

class CoreApp extends ConsumerWidget {
  const CoreApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    // final authState = ref.watch(isAuthenticatedProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appDisplayName,
      theme: lightTheme(),
      darkTheme: darkTheme(),
      restorationScopeId: 'app',
      locale: const Locale('fr'),
      supportedLocales: L10n.all,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: const ScanPage(),
      // home: authState.when(
      //   error: (error, stackTrace) {
      //     FlutterNativeSplash.remove();
      //     return ErrorPage(error: error.toString());
      //   },
      //   loading: () => const LoadingPage(),
      //   data: (authValue) {
      //     FlutterNativeSplash.remove();
      //     if (authValue.isAuthenticated && authValue.isLinkedToASchool) {
      //       return const ScanPage();
      //     } else if (authValue.isAuthenticated &&
      //         !authValue.isLinkedToASchool) {
      //       AppUtils.infoDialog(
      //         context: context,
      //         text: "Votre compte n'est pas lié à une école",
      //         onPressed: () {
      //           ref.read(authControllerProvider.notifier).signOut().then(
      //                 (_) => Navigator.of(context).pushAndRemoveUntil(
      //                   MaterialPageRoute<SignInPage>(
      //                     builder: (_) => const SignInPage(),
      //                   ),
      //                   (route) => false,
      //                 ),
      //               );
      //
      //           Navigator.of(context).pop();
      //         },
      //       );
      //     } else {
      //       return const SignInPage();
      //     }
      //     return const SignInPage();
      //   },
      // ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yeko_pointage/commons/commons.dart';
import 'package:yeko_pointage/features/auth/presentation/controllers/sign_in_controller.dart';
import 'package:yeko_pointage/features/temp_page.dart';
import 'package:yeko_pointage/utils/app_utils.dart';

class SignInPage extends HookConsumerWidget {
  const SignInPage({super.key});

  static MaterialPageRoute<SignInPage> route() => MaterialPageRoute<SignInPage>(
        builder: (context) => const SignInPage(),
      );

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    final emailController =
        useTextEditingController(text: 'kassidarius@gmail.com');
    /* cspell:disable */
    final passwordController = useTextEditingController(text: 'Aazzeerrtt88');
    /* cspell:enable */

    final signInState = ref.watch(signInControllerProvider);

    final size = MediaQuery.of(context).size;

    Future<void> onSignIn() async {
      final signInController = ref.read(signInControllerProvider.notifier);

      final response = await signInController.eitherFailureOrSignIn(
        email: emailController.text.trim().toLowerCase(),
        password: passwordController.text.trim(),
      );

      await response.fold(
        (l) => AppUtils.showAlertDialog(
          context: context,
          title: 'Erreur',
          content: l.errorMessage,
          confirmText: 'OK',
        ),
        (r) => Navigator.pushAndRemoveUntil(
          context,
          TempPage.route(),
          (route) => false,
        ),
      );
    }

    return Scaffold(
      body: LoadingStateWrapper(
        isLoading: signInState,
        child: Flex(
          mainAxisAlignment: MainAxisAlignment.center,
          direction: Axis.vertical,
          children: [
            Form(
              key: _formKey,
              child: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width * 0.4,
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: size.height * 0.1),

                            // lock icon part
                            Container(
                              height: 140,
                              width: 140,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colorScheme.primaryContainer,
                              ),
                              child: Icon(
                                Icons.lock,
                                size: 70,
                                color: colorScheme.primary,
                              ),
                            ),

                            SizedBox(height: size.height * 0.1),

                            // title part
                            const Text(
                              'Connectez-vous pour continuer',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            largeColDivider,

                            // subtitle part
                            const Text(
                              'Veillez entrer vos information pour vous connecter',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),

                            colDivider,

                            CustomTextFormField(
                              labelText: "Entrer l'email de l'école",
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              size: const Size(72, 12),
                            ),

                            colDivider,

                            CustomTextFormField(
                              labelText: 'Entrer le mot de passe',
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (_) {
                                final isValid =
                                    _formKey.currentState?.validate();
                                if (isValid!) {
                                  onSignIn();
                                }
                              },
                              controller: passwordController,
                              obscureText: true,
                              size: const Size(72, 12),
                            ),

                            SizedBox(height: size.height * 0.1),

                            // button part
                            CustomMaterialButton(
                              text: 'Se connecter',
                              onPressed: () {
                                final isValid =
                                    _formKey.currentState?.validate();
                                if (isValid!) {
                                  onSignIn();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
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

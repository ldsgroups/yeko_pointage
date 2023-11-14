import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yeko_pointage/commons/commons.dart';
import 'package:yeko_pointage/core/constants/constants.dart';
import 'package:yeko_pointage/core/validators.dart';
import 'package:yeko_pointage/features/auth/presentation/controllers/sign_in_controller.dart';
import 'package:yeko_pointage/features/auth/presentation/pages/locking_page.dart';
import 'package:yeko_pointage/utils/app_utils.dart';

class SignInPage extends HookConsumerWidget {
  const SignInPage({super.key});

  static MaterialPageRoute<SignInPage> route() => MaterialPageRoute<SignInPage>(
        builder: (context) => const SignInPage(),
      );

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController =
        useTextEditingController(text: 'kassidarius@gmail.com');
    /* cspell:disable */
    final passwordController = useTextEditingController(text: 'Aazzeerrtt88');
    /* cspell:enable */

    final signInState = ref.watch(signInControllerProvider);

    final size = MediaQuery.of(context).size;
    final isTablet = size.width > size.height;

    Future<void> onSignIn() async {
      // Validate form before process signIn
      final isValid = _formKey.currentState?.validate();
      if (isValid!) {
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
            LockingPage.route(),
            (route) => false,
          ),
        );
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Logo part
                SizedBox(
                  width: isTablet ? size.width * 0.3 : size.width * 0.5,
                  child: Image.asset(
                    AssetConstants.appLogoLight,
                    fit: BoxFit.cover,
                  ),
                ),

                // Form part
                SizedBox(
                  width: isTablet ? size.width * 0.55 : size.width,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          enabled: !signInState,
                          controller: emailController,
                          hintText: 'Entrer votre email',
                          validator: CustomValidator.validateEmail,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        smallColDivider,
                        CustomTextFormField(
                          enabled: !signInState,
                          controller: passwordController,
                          validator: CustomValidator.validatePassword,
                          hintText: 'Entrer votre mot de passe',
                          obscureText: true,
                        ),
                        largeColDivider,
                        CustomMaterialButton(
                          text: 'Se connecter',
                          isLoading: signInState,
                          onPressed: onSignIn,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yeko_pointage/commons/commons.dart';
import 'package:yeko_pointage/core/constants/constants.dart';
import 'package:yeko_pointage/core/utils/app_utils.dart';
import 'package:yeko_pointage/core/validators.dart';
import 'package:yeko_pointage/features/auth/auth.dart';
import 'package:yeko_pointage/features/auth/controllers/auth_controller.dart';

class SignInPage extends HookConsumerWidget {
  const SignInPage({super.key});

  static MaterialPageRoute<SignInPage> route() => MaterialPageRoute<SignInPage>(
        builder: (context) => const SignInPage(),
      );

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uidController =
        useTextEditingController(text: 'kassidarius@gmail.com');
    /* cspell:disable */
    final passwordController = useTextEditingController(text: 'strongPassword');
    /* cspell:enable */

    final signInState = ref.watch(authControllerProvider);

    final size = MediaQuery.of(context).size;
    final isTablet = size.width > size.height;

    Future<void> onSignIn() async {
      // Validate form before process signIn
      final isValid = _formKey.currentState?.validate();
      if (isValid!) {
        final authCtrl = ref.read(authControllerProvider.notifier);

        final response = await authCtrl.signInWithUidAndPassword(
          uid: uidController.text.trim().toLowerCase(),
          password: passwordController.text.trim(),
        );

        response.fold(
          (l) => AppUtils.showSnackBar(
            context,
            l.errorMessage,
          ),
          (userId) async {
            final me = await authCtrl.me(userId: userId!);

            await me.fold(
              (l) {
                return AppUtils.infoDialog(
                  context: context,
                  text: "Votre compte n'est pas lié à une école",
                  onPressed: () {
                    ref.read(authControllerProvider.notifier).signOut();
                    Navigator.of(context).pop();
                  },
                );
              },
              (r) {
                if (r != null && r.schoolId != null) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    ScanPage.route(),
                    (route) => false,
                  );
                }
              },
            );
          },
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
                  width: isTablet ? size.width * 0.55 : size.width * 0.95,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          enabled: !signInState,
                          controller: uidController,
                          hintText: 'Entrer votre email ou votre identifiant',
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

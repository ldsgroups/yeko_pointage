import 'package:flutter/material.dart';
import 'package:yeko_pointage/commons/commons.dart';
import 'package:yeko_pointage/core/constants/asset_constants.dart';

class AppUtils {
  // Prevent the utility class from being instantiated.
  AppUtils._();

  /// Shows a snack-bar with the given [content] in the [context].
  static void showSnackBar(BuildContext context, String content) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(content)));
  }

  /// Displays an alert dialog to the user.
  ///
  /// The [title] parameter is the title of the dialog.
  /// The [content] parameter is the content of the dialog.
  /// The [confirmText] parameter is the text to display on the confirm button.
  /// The [onConfirm] parameter is the function to call when the confirm button is pressed.
  /// The [cancelText] parameter is the text to display on the cancel button.
  /// The [onCancel] parameter is the function to call when the cancel button is pressed.
  static Future<void> showAlertDialog({
    required BuildContext context,
    required Widget content,
    String? textContent,
    String? title,
    String? confirmText,
    String? cancelText,
    int? duration = 2500,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) async {
    // Set initial values for title, confirmText and cancelText if they are null
    title ??= 'Alert';
    onConfirm ??= () => Navigator.pop(context);
    onCancel ??= () => Navigator.pop(context);

    // if confirmText and cancelText are null, pop the dialog after 2500 ms
    if (confirmText == null && cancelText == null) {
      Future.delayed(
        Duration(milliseconds: duration!),
        () => Navigator.pop(context),
      );
    }

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title!),
          content: textContent != null ? Text(textContent) : content,
          actions: confirmText == null && cancelText == null
              ? null
              : [
                  if (cancelText != null)
                    TextButton(
                      onPressed: onCancel,
                      child: Text(cancelText),
                    ),
                  if (confirmText != null)
                    TextButton(
                      onPressed: onConfirm,
                      child: Text(confirmText),
                    ),
                ],
        );
      },
    );
  }

  static Future<void> infoDialog({
    required BuildContext context,
    required String text,
    required void Function()? onPressed,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetAnimationDuration: const Duration(
            milliseconds: 300,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                AssetConstants.appLogoLight,
                width: 120,
              ),
              colDivider,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  text,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              largeColDivider,
              const Divider(),
              TextButton(
                onPressed: onPressed,
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<void> yesOrNoModal({
    required BuildContext context,
    required void Function()? onConfirm,
    required void Function()? onCancel,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetAnimationDuration: const Duration(
            milliseconds: 300,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                AssetConstants.appLogoLight,
                width: 120,
              ),
              colDivider,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'Avez-vous donnez un exercice de maison?',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              largeColDivider,
              Row(
                children: [
                  Expanded(
                    child: YesNoButton(
                      text: 'NON',
                      withBottomLeftRadius: true,
                      onTap: onCancel,
                    ),
                  ),
                  Expanded(
                    child: YesNoButton(
                      text: 'OUI',
                      withBottomRightRadius: true,
                      onTap: onConfirm,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

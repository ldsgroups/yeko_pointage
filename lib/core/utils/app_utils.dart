import 'package:flutter/material.dart';

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
}

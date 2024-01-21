import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yeko_pointage/commons/commons.dart';
import 'package:yeko_pointage/core/core.dart';

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
      barrierDismissible: false,
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

  /// Shows a date picker dialog and allows the user to select a date.
  ///
  /// The [selectDate] function displays a date picker dialog using [showDatePicker]
  /// and allows the user to select a date. It is an asynchronous function that returns
  /// a [Future] with no return value ([void]). The selected date is passed to the
  /// [onDateSelected] callback function.
  ///
  /// The [context] parameter represents the build context used to show the date picker dialog.
  ///
  /// The [initialDate] parameter represents the initial date value displayed in the date picker.
  /// If not provided, the current date [DateTime.now()] is used as the initial date.
  ///
  /// The [lastDate] parameter represents the maximum selectable date in the date picker.
  /// If not provided, the current date [DateTime.now()] is used as the last date.
  ///
  /// The [onDateSelected] parameter is a required callback function that receives the selected
  /// date as a [DateTime]. It is called when the user selects a date in the date picker.
  ///
  /// Usage example:
  /// ```dart
  /// await selectDate(
  ///   context: context,
  ///   initialDate: DateTime(2023, 1, 1),
  ///   lastDate: DateTime(2023, 12, 31),
  ///   onDateSelected: (selectedDate) {
  ///     // Handle the selected date
  ///     print('Selected date: $selectedDate');
  ///   },
  /// );
  /// ```
  static Future<void> selectDate({
    required BuildContext context,
    required ValueChanged<DateTime> onDateSelected,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    // Set default values for initialDate and lastDate if they are null
    initialDate ??= DateTime.now();
    lastDate ??= DateTime.now();

    // Show the date picker dialog and wait for the user to select a date
    final picked = await showDatePicker(
      context: context,
      // locale: const Locale('fr', 'FR'),
      initialDate: initialDate,
      firstDate: firstDate ??= DateTime(initialDate.year - 1),
      lastDate: lastDate,
    );

    // Invoke the onDateSelected callback if a date is picked
    if (picked != null) {
      onDateSelected(picked);
    }
  }

  /// Formats a date into a string representation using a specified format.
  ///
  /// The [formatDate] function takes a [date] as input and formats it into a string
  /// representation based on the specified [style] of the date format. The [date]
  /// parameter can be either a [String] representing a valid date in the format
  /// 'yyyy-MM-dd', or a [DateTime] object. The [style] parameter is an optional
  /// parameter of type [DateFormatType] that specifies the style of the formatted date.
  /// It defaults to [DateFormatType.regular].
  ///
  /// The function returns a [String] representing the formatted date based on the
  /// specified [style]. The [DateFormatType] enum is used to specify the style of
  /// the formatted date, with options: [DateFormatType.short], [DateFormatType.regular],
  /// and [DateFormatType.long].
  ///
  /// The [DateFormat] class from the `intl` package is used to format the date.
  /// The specific format is determined based on the [style] parameter.
  ///
  /// Usage example:
  /// ```dart
  /// String formattedDate = formatDate('2023-05-23');
  /// print(formattedDate); // Output: '23 mai'
  ///
  /// String customFormattedDate = formatDate(DateTime(2023, 5, 22), DateFormatType.short);
  /// print(customFormattedDate); // Output: '22/05'
  /// ```
  static String formatDate(
    dynamic date, [
    DateFormatType style = DateFormatType.regular,
  ]) {
    DateTime inputDate;

    // Parse the input date based on its type
    if (date is String) {
      inputDate = DateTime.parse(date);
    } else if (date is DateTime) {
      inputDate = date;
    } else {
      throw ArgumentError('date must be a String or DateTime');
    }

    DateFormat dateFormatter;

    // Determine the date format based on the specified style
    if (style == DateFormatType.long) {
      // ex: 'Saturday, May 23'
      dateFormatter = DateFormat('EEEE DD MMM', 'fr');
    } else if (style == DateFormatType.short) {
      dateFormatter = DateFormat('dd/MM');
    } else {
      dateFormatter = DateFormat('d MMM', 'fr');
    }

    // Format the date using the determined date format
    return dateFormatter.format(inputDate);
  }
}

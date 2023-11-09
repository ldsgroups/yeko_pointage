import 'package:flutter/services.dart';

/// A [TextInputFormatter] that formats the text input
/// for phone numbers in the format "## ## ## ##".
class PhoneNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newTextLength = newValue.text.length;
    final newText = StringBuffer();

    for (var i = 0; i < newTextLength; i++) {
      // Add a space every two characters, starting from the second character
      if (i > 0 && i.isEven) {
        newText.write(' ');
      }

      // Add the current character of the new text
      newText.write(newValue.text[i]);
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

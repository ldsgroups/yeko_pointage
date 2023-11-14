const String _emailValidatorRegExp = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
const String _phoneValidatorRegExp = r'^\+(?:\d{1,3})?\d{10}$';

class CustomValidator {
  static String? validateEmail(String? value) {
    final regex = RegExp(_emailValidatorRegExp);
    if (value == null || !regex.hasMatch(value)) {
      return "Cet email n'est pas correct";
    } else {
      return null;
    }
  }

  static String? validatePassword(String? value) {
    if (value == null || value.length < 8) {
      return 'Le mot de passe trop court (8 min)';
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(String value) {
    final regex = RegExp(_phoneValidatorRegExp);
    if (!regex.hasMatch(value)) {
      return "Ce numéro n'est pas valide";
    } else {
      return null;
    }
  }

  static String? validateMinLength(String value, int minLength) {
    if (value.trim().length < minLength) {
      return 'Trop court, ($minLength min)';
    } else {
      return null;
    }
  }

  static String? validateMaxLength(String value, int maxLength) {
    if (value.trim().length > maxLength) {
      return 'Trop long ($maxLength max)';
    } else {
      return null;
    }
  }

  static String? validateIsNumber(String value) {
    try {
      return null;
    } catch (e) {
      return "Cette valeur n'est pas un nombre";
    }
  }

  static String? validateIsString(String value) {
    if (value.trim().isEmpty) {
      return 'Please enter a valid string.';
    } else {
      return null;
    }
  }

  static String? validateIsDateBefore(String value, String dateBefore) {
    if (DateTime.parse(value.trim()).isBefore(DateTime.parse(dateBefore))) {
      return 'La date doit être avant $dateBefore.';
    } else {
      return null;
    }
  }

  static String? validateIsDateAfter(String value, String dateAfter) {
    if (DateTime.parse(value.trim()).isAfter(DateTime.parse(dateAfter))) {
      return 'La date doit être après $dateAfter.';
    } else {
      return null;
    }
  }
}

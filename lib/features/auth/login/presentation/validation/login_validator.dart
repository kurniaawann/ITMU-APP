//validator untuk Email Login page
class LoginValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Harap masukkan email ';
    } else if (!RegExp(
            r'^[a-zA-Z0-9._%+-]+(?<!\.)@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}(?:\.[a-zA-Z]{2,})?$')
        .hasMatch(value)) {
      return 'Email yang anda masukkan tidak valid';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Harap masukkan password ';
    }

    return null;
  }
}

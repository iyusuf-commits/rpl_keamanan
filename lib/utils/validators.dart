class Validators {
  static bool isValidEmail(String email) {
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return regex.hasMatch(email);
  }

  static bool isNotEmpty(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  static bool hasValidLength(String value, {int min = 1, int max = 100}) {
    final length = value.trim().length;
    return length > min && length < max;
  }

  static String sanitize(String input) {
    return input
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#x27;')
        .trim();
  }

  static String? validateText(
    String? value, {
    String fieldName = 'Field',
    int minLength = 1,
    int maxLength = 100,
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName tidak boleh kosong';
    }
    if (!hasValidLength(value, min: minLength, max: maxLength)) {
      return '$fieldName harus antara $minLength-$maxLength karakter';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email tidak boleh kosong';
    if (!isValidEmail(value.trim())) return 'Format email tidak valid';
    return null;
  }

  // LATIHAN 3: Tambahan Validasi
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Nomor telepon tidak boleh kosong';
    if (!RegExp(r'^\d{10,13}$').hasMatch(value)) {
      return 'Nomor telepon harus angka (10-13 digit)';
    }
    return null;
  }

  static String? validateUrl(String? value) {
    if (value == null || value.isEmpty) return 'URL tidak boleh kosong';
    if (!RegExp(r'^(http:\/\/|https:\/\/)').hasMatch(value)) {
      return 'URL harus diawali dengan http:// atau https://';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password tidak boleh kosong';
    // Min 8 karakter, mengandung huruf kapital, angka, dan simbol
    if (!RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$').hasMatch(value)) {
      return 'Password minimal 8 karakter, ada huruf kapital, angka, & simbol';
    }
    return null;
  }
}
class Validators {
  const Validators._();

  static String? requiredField(
    String? value, {
    String message = 'This field is required',
  }) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }

    return null;
  }

  static String? location(String? value) {
    return requiredField(value, message: 'Location is required');
  }

  static String? notes(String? value) {
    return requiredField(value, message: 'Note is required');
  }
}

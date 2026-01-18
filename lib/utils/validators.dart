/// Validators for form input validation
class Validators {
  Validators._();

  /// Validates phone number
  /// Accepts numbers with optional spaces, dashes, or parentheses
  /// Minimum 8 digits, maximum 11 digits
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }

    // Remove all non-digit characters for validation
    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');

    // Check if it contains only digits (after removing formatting)
    if (digitsOnly.isEmpty) {
      return 'Please enter a valid phone number';
    }

    // Check length (8-11 digits for this app)
    if (digitsOnly.length < 8) {
      return 'Phone number is too short';
    }

    if (digitsOnly.length > 11) {
      return 'Phone number is too long';
    }

    return null;
  }

  /// Validates password
  /// Requirements:
  /// - At least 6 characters
  /// - Contains at least one letter
  /// - Contains at least one number
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    // Check if contains at least one letter
    if (!RegExp('[a-zA-Z]').hasMatch(value)) {
      return 'Password must contain at least one letter';
    }

    // Check if contains at least one number
    if (!RegExp('[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }

    return null;
  }

  /// Validates password confirmation
  /// Checks if the password matches the original password
  static String? validatePasswordConfirm(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password again';
    }

    if (value != password) {
      return 'Passwords do not match';
    }

    return null;
  }

  /// Validates verification code (VCode)
  /// Requirements:
  /// - Exactly 6 digits
  static String? validateVCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your vcode';
    }

    // Check if it's exactly 6 digits
    if (!RegExp(r'^\d{6}$').hasMatch(value)) {
      return 'VCode must be 6 digits';
    }

    return null;
  }

  /// Validates email address
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  /// Validates required field (not empty)
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter your $fieldName';
    }
    return null;
  }
}

/// App-wide string constants
class AppStrings {
  AppStrings._();

  // App
  static const String appTitle = 'Login Page';

  // Login
  static const String login = 'Login';
  static const String loginHint = 'Sign in to your account';

  // Register
  static const String register = 'Register';
  static const String registerHint = 'Create a new account';

  // Form fields
  static const String phoneNumberHint = 'Enter Your Phone Number';
  static const String passwordHint = 'Enter Your Password';
  static const String passwordAgainHint = 'Enter Your Password Again';
  static const String vCodeHint = 'Enter Your VCode';
  static const String getVCode = 'Get VCode';

  // Validation messages
  static const String phoneNumberRequired = 'Please enter your phone number';
  static const String phoneNumberInvalid = 'Please enter a valid phone number';
  static const String passwordRequired = 'Please enter your password';
  static const String passwordTooShort = 'Password must be at least 6 characters';
  static const String passwordTooWeak = 'Password must contain letters and numbers';
  static const String passwordAgainRequired = 'Please enter your password again';
  static const String passwordNotMatch = 'Passwords do not match';
  static const String vCodeRequired = 'Please enter your vcode';
  static const String vCodeInvalid = 'VCode must be 6 digits';

  // Tooltips
  static const String togglePasswordVisibility = 'Show or hide your password';

  // Buttons
  static const String loginButton = 'Login';
  static const String registerButton = 'Register';
  static const String haveAccount = 'Already have an account? Login';
  static const String noAccount = 'Don\'t have an account? Register';
}

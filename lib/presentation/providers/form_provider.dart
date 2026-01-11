import 'package:flutter/foundation.dart';
import 'package:flutter_aos/constants/area_codes.dart';

/// Form state provider
/// Manages form-specific state like area code selection and password visibility
class FormProvider with ChangeNotifier {
  String _areaCode = AreaCodes.defaultCode;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  String get areaCode => _areaCode;
  bool get obscurePassword => _obscurePassword;
  bool get obscureConfirmPassword => _obscureConfirmPassword;

  /// Change area code
  void setAreaCode(String code) {
    _areaCode = code;
    notifyListeners();
  }

  /// Toggle password visibility
  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  /// Toggle confirm password visibility
  void toggleConfirmPasswordVisibility() {
    _obscureConfirmPassword = !_obscureConfirmPassword;
    notifyListeners();
  }

  /// Reset form state
  void reset() {
    _areaCode = AreaCodes.defaultCode;
    _obscurePassword = true;
    _obscureConfirmPassword = true;
    notifyListeners();
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter_aos/utils/app_logger.dart';

/// Authentication state provider
/// Manages login and registration logic
class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  bool _isAuthenticated = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _isAuthenticated;

  /// Login with phone number and password
  Future<bool> login({
    required String areaCode,
    required String phoneNumber,
    required String password,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      AppLogger.i('Attempting login with phone: $areaCode$phoneNumber');

      // Simulate API call
      await Future<void>.delayed(const Duration(seconds: 2));

      // TODO: Replace with actual API call
      // final response = await authRepository.login(areaCode, phoneNumber, password);

      // For now, just simulate success
      _isAuthenticated = true;
      _setLoading(false);

      AppLogger.i('Login successful');
      return true;
    } catch (e, stackTrace) {
      AppLogger.e('Login failed', e, stackTrace);
      _setError('Login failed. Please try again.');
      _setLoading(false);
      return false;
    }
  }

  /// Register new user
  Future<bool> register({
    required String areaCode,
    required String phoneNumber,
    required String password,
    required String vCode,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      AppLogger.i('Attempting registration with phone: $areaCode$phoneNumber');

      // Simulate API call
      await Future<void>.delayed(const Duration(seconds: 2));

      // TODO: Replace with actual API call
      // final response = await authRepository.register(
      //   areaCode, phoneNumber, password, vCode
      // );

      // For now, just simulate success
      _setLoading(false);

      AppLogger.i('Registration successful');
      return true;
    } catch (e, stackTrace) {
      AppLogger.e('Registration failed', e, stackTrace);
      _setError('Registration failed. Please try again.');
      _setLoading(false);
      return false;
    }
  }

  /// Request verification code
  Future<bool> requestVCode({
    required String areaCode,
    required String phoneNumber,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      AppLogger.i('Requesting VCode for phone: $areaCode$phoneNumber');

      // Simulate API call
      await Future<void>.delayed(const Duration(seconds: 1));

      // TODO: Replace with actual API call
      // final response = await authRepository.requestVCode(areaCode, phoneNumber);

      _setLoading(false);

      AppLogger.i('VCode sent successfully');
      return true;
    } catch (e, stackTrace) {
      AppLogger.e('Failed to send VCode', e, stackTrace);
      _setError('Failed to send verification code. Please try again.');
      _setLoading(false);
      return false;
    }
  }

  /// Logout
  void logout() {
    _isAuthenticated = false;
    _clearError();
    AppLogger.i('User logged out');
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}

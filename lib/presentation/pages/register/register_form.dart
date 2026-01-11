import 'package:flutter/material.dart';
import 'package:flutter_aos/config/routes/app_router.dart';
import 'package:flutter_aos/constants/app_colors.dart';
import 'package:flutter_aos/constants/app_dimens.dart';
import 'package:flutter_aos/constants/app_strings.dart';
import 'package:flutter_aos/presentation/providers/auth_provider.dart';
import 'package:flutter_aos/presentation/providers/form_provider.dart';
import 'package:flutter_aos/presentation/widgets/common/area_code_picker.dart';
import 'package:flutter_aos/presentation/widgets/common/custom_button.dart';
import 'package:flutter_aos/presentation/widgets/common/custom_text_form_field.dart';
import 'package:flutter_aos/utils/app_logger.dart';
import 'package:flutter_aos/utils/validators.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

/// Register form widget with Provider state management
class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _vCodeController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _vCodeController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      AppLogger.w('Registration form validation failed');
      return;
    }

    _formKey.currentState?.save();

    final authProvider = context.read<AuthProvider>();
    final formProvider = context.read<FormProvider>();

    final success = await authProvider.register(
      areaCode: formProvider.areaCode,
      phoneNumber: _phoneController.text,
      password: _passwordController.text,
      vCode: _vCodeController.text,
    );

    if (success && mounted) {
      AppLogger.i('Registration successful, navigating to login');
      _formKey.currentState?.reset();
      formProvider.reset();
      context.go(AppRoutes.login);
    } else if (mounted) {
      _showErrorSnackBar(authProvider.errorMessage ?? 'Registration failed');
    }
  }

  Future<void> _handleGetVCode() async {
    // Validate phone number first
    if (_phoneController.text.isEmpty ||
        Validators.validatePhoneNumber(_phoneController.text) != null) {
      _showErrorSnackBar('Please enter a valid phone number first');
      return;
    }

    final authProvider = context.read<AuthProvider>();
    final formProvider = context.read<FormProvider>();

    final success = await authProvider.requestVCode(
      areaCode: formProvider.areaCode,
      phoneNumber: _phoneController.text,
    );

    if (success && mounted) {
      _showSuccessSnackBar('Verification code sent successfully');
    } else if (mounted) {
      _showErrorSnackBar(
        authProvider.errorMessage ?? 'Failed to send verification code',
      );
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.success,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, FormProvider>(
      builder: (context, authProvider, formProvider, child) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Phone number field
              CustomTextFormField(
                controller: _phoneController,
                hintText: AppStrings.phoneNumberHint,
                keyboardType: TextInputType.phone,
                prefixIcon: AreaCodePicker(
                  selectedAreaCode: formProvider.areaCode,
                  onChanged: formProvider.setAreaCode,
                ),
                validator: Validators.validatePhoneNumber,
              ),
              const SizedBox(height: AppDimens.formFieldSpacing),

              // Password field
              CustomTextFormField(
                controller: _passwordController,
                hintText: AppStrings.passwordHint,
                obscureText: formProvider.obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    formProvider.obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppColors.iconGrey,
                  ),
                  tooltip: AppStrings.togglePasswordVisibility,
                  onPressed: formProvider.togglePasswordVisibility,
                ),
                validator: Validators.validatePassword,
              ),
              const SizedBox(height: AppDimens.formFieldSpacing),

              // Confirm password field
              CustomTextFormField(
                controller: _confirmPasswordController,
                hintText: AppStrings.passwordAgainHint,
                obscureText: formProvider.obscureConfirmPassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    formProvider.obscureConfirmPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppColors.iconGrey,
                  ),
                  tooltip: AppStrings.togglePasswordVisibility,
                  onPressed: formProvider.toggleConfirmPasswordVisibility,
                ),
                validator: (value) => Validators.validatePasswordConfirm(
                  value,
                  _passwordController.text,
                ),
              ),
              const SizedBox(height: AppDimens.formFieldSpacing),

              // VCode field with button
              CustomTextFormField(
                controller: _vCodeController,
                hintText: AppStrings.vCodeHint,
                keyboardType: TextInputType.number,
                maxLength: 6,
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(AppDimens.paddingSmall),
                  child: CustomButtonSmall(
                    text: AppStrings.getVCode,
                    onPressed: authProvider.isLoading ? null : _handleGetVCode,
                    isLoading: authProvider.isLoading,
                  ),
                ),
                validator: Validators.validateVCode,
              ),
              const SizedBox(height: AppDimens.marginXXLarge),

              // Register button
              CustomButton(
                text: AppStrings.registerButton,
                onPressed: authProvider.isLoading ? null : _handleRegister,
                isLoading: authProvider.isLoading,
                width: double.infinity,
              ),
              const SizedBox(height: AppDimens.marginMedium),

              // Navigate to login
              TextButton(
                onPressed: () => context.go(AppRoutes.login),
                child: const Text(AppStrings.haveAccount),
              ),
            ],
          ),
        );
      },
    );
  }
}

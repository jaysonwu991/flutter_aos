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
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

/// Login form widget with Provider state management
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      AppLogger.w('Login form validation failed');
      return;
    }

    _formKey.currentState?.save();

    final authProvider = context.read<AuthProvider>();
    final formProvider = context.read<FormProvider>();

    final success = await authProvider.login(
      areaCode: formProvider.areaCode,
      phoneNumber: _phoneController.text,
      password: _passwordController.text,
    );

    if (success && mounted) {
      AppLogger.i('Login successful');
      _showSuccessSnackBar('Login successful!');
      // Navigate to home page or dashboard
      // For now, just show success message
    } else if (mounted) {
      _showErrorSnackBar(authProvider.errorMessage ?? 'Login failed');
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
                maxLength: 11,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.start,
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
              const SizedBox(height: AppDimens.marginXXLarge),

              // Login button
              CustomButton(
                text: AppStrings.loginButton,
                onPressed: authProvider.isLoading ? null : _handleLogin,
                isLoading: authProvider.isLoading,
                width: double.infinity,
              ),
              const SizedBox(height: AppDimens.marginMedium),

              // Navigate to register
              TextButton(
                onPressed: () => context.go(AppRoutes.register),
                child: const Text(AppStrings.noAccount),
              ),
            ],
          ),
        );
      },
    );
  }
}

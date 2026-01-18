import 'package:flutter/material.dart';
import 'package:flutter_aos/constants/app_colors.dart';
import 'package:flutter_aos/constants/app_dimens.dart';
import 'package:flutter/services.dart';

/// Custom text form field with consistent styling
class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.controller,
    this.maxLength,
    this.inputFormatters,
    this.textAlign,
    this.textDirection,
    this.style,
    this.enabled = true,
    super.key,
  });

  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextStyle? style;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      textAlign: textAlign ?? TextAlign.start,
      textDirection: textDirection,
      style: style ?? const TextStyle(color: AppColors.textPrimary),
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
      enabled: enabled,
      maxLength: maxLength,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.textHint),
        errorStyle: const TextStyle(
          color: AppColors.error,
          fontSize: 12,
        ),
        errorMaxLines: 2,
        prefixIcon: prefixIcon,
        prefixIconConstraints: prefixIcon != null
            ? const BoxConstraints(
                minWidth: 0,
                minHeight: 0,
              )
            : null,
        suffixIcon: suffixIcon,
        counterText: '',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
          borderSide: const BorderSide(color: AppColors.formBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
          borderSide: const BorderSide(color: AppColors.formBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
          borderSide: const BorderSide(color: AppColors.formFocused, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
          borderSide: const BorderSide(color: AppColors.formError),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
          borderSide: const BorderSide(color: AppColors.formError, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimens.paddingMedium,
          vertical: AppDimens.paddingMedium,
        ),
      ),
    );
  }
}

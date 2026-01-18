import 'package:flutter/material.dart';
import 'package:flutter_aos/constants/app_colors.dart';
import 'package:flutter_aos/constants/app_dimens.dart';

/// Custom button with consistent styling
class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    super.key,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? AppDimens.buttonHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.buttonPrimary,
          disabledBackgroundColor: AppColors.buttonDisabled,
          padding: const EdgeInsets.symmetric(
            vertical: AppDimens.buttonPaddingVertical,
            horizontal: AppDimens.buttonPaddingHorizontal,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                width: AppDimens.iconMedium,
                height: AppDimens.iconMedium,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.textWhite),
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  fontSize: fontSize ?? AppDimens.fontLarge,
                  color: textColor ?? AppColors.textWhite,
                  fontWeight: FontWeight.w500,
                  height: 1.1,
                ),
              ),
      ),
    );
  }
}

/// Small variant of custom button
class CustomButtonSmall extends StatelessWidget {
  const CustomButtonSmall({
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    super.key,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      height: AppDimens.buttonHeightSmall,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: AppDimens.fontMedium,
    );
  }
}

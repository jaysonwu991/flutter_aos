import 'package:flutter/material.dart';
import 'package:flutter_aos/constants/app_dimens.dart';

/// Login image widget
class LoginImage extends StatelessWidget {
  const LoginImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimens.marginLarge),
      alignment: Alignment.center,
      child: Image.asset(
        'assets/imgs/login_logo.png',
        fit: BoxFit.cover,
        height: 120,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(
            Icons.image_not_supported,
            size: 120,
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_aos/constants/app_dimens.dart';
import 'package:flutter_aos/presentation/pages/login/login_form.dart';
import 'package:flutter_aos/presentation/pages/login/login_image.dart';

/// Login page
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppDimens.paddingLarge),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: AppDimens.maxFormWidth,
                ),
                child: const Column(
                  children: [
                    LoginImage(),
                    LoginForm(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

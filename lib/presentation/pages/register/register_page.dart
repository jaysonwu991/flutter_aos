import 'package:flutter/material.dart';
import 'package:flutter_aos/constants/app_dimens.dart';
import 'package:flutter_aos/presentation/pages/register/register_form.dart';
import 'package:flutter_aos/presentation/pages/register/register_image.dart';

/// Register page
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Opening'),
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
                    RegisterImage(),
                    RegisterForm(),
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

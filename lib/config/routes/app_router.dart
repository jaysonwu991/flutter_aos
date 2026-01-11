import 'package:flutter/material.dart';
import 'package:flutter_aos/presentation/pages/login/login_page.dart';
import 'package:flutter_aos/presentation/pages/register/register_page.dart';
import 'package:go_router/go_router.dart';

/// Route names
class AppRoutes {
  AppRoutes._();

  static const String login = '/login';
  static const String register = '/';
}

/// App router configuration
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.register,
  routes: [
    GoRoute(
      path: AppRoutes.register,
      name: 'register',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const RegisterPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.login,
      name: 'login',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const LoginPage(),
      ),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Error: ${state.error}'),
    ),
  ),
);

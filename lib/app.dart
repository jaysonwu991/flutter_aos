import 'package:flutter/material.dart';
import 'package:flutter_aos/config/routes/app_router.dart';
import 'package:flutter_aos/constants/app_colors.dart';
import 'package:flutter_aos/constants/app_strings.dart';
import 'package:flutter_aos/presentation/providers/auth_provider.dart';
import 'package:flutter_aos/presentation/providers/form_provider.dart';
import 'package:provider/provider.dart';

/// Main app widget with Provider and go_router configuration
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => FormProvider()),
      ],
      child: MaterialApp.router(
        title: AppStrings.appTitle,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: AppColors.primary as MaterialColor,
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            brightness: Brightness.light,
          ),
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 0,
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: AppColors.background,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        routerConfig: appRouter,
      ),
    );
  }
}

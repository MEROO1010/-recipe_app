// lib/ui/styles/styles.dart
import 'package:flutter/material.dart';
import 'package:recipe_app/ui/colors/colors.dart';
import 'package:recipe_app/ui/fonts/fonts.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primary,
      primaryColorLight: AppColors.primaryVariant,
      hintColor: AppColors.secondary,
      scaffoldBackgroundColor: AppColors.background,
      cardColor: AppColors.error,
      textTheme: TextTheme(
        displayLarge: AppFonts.headline1,
        displayMedium: AppFonts.headline2,
        bodyLarge: AppFonts.bodyText1,
        bodyMedium: AppFonts.bodyText2,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: AppColors.primary,
        textTheme: ButtonTextTheme.primary,
      ),
      colorScheme: ColorScheme(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        background: AppColors.background,
        error: AppColors.error,
        onPrimary: AppColors.onPrimary,
        onSecondary: AppColors.onSecondary,
        onSurface: AppColors.onSurface,
        onBackground: AppColors.onBackground,
        onError: AppColors.onError,
        brightness: Brightness.light,
      ),
    );
  }
}

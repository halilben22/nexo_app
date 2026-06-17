import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexo_app/core/theme/app_colors.dart';
import 'package:nexo_app/core/theme/app_dimensions.dart';
import 'package:nexo_app/core/theme/app_radius.dart';
import 'package:nexo_app/core/theme/app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,

    scaffoldBackgroundColor: AppColors.background,
    textTheme: GoogleFonts.interTextTheme(
      ThemeData.dark().textTheme.apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
      ),
    ),

    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      tertiary: AppColors.tertiary,
      secondary: AppColors.secondary,
      error: AppColors.error,
      surface: AppColors.background,
      background: AppColors.background,
      onBackground: AppColors.textPrimary,
      onSurface: AppColors.textPrimary,
      onPrimary: Colors.black,
    ),

    //APPBAR THEME OPSİONEL
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        minimumSize: Size(double.infinity, AppDimensions.buttonHeight),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.primaryButton,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        textStyle: AppTextStyles.body,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.neutral,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: const BorderSide(color: AppColors.border),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: const BorderSide(color: AppColors.border),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: const BorderSide(color: AppColors.error),
      ),
    ),

    cardTheme: CardThemeData(
      elevation: 0,
      color: AppColors.cardPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
    ),
  );

  //lightTheme will be add for the next step
}

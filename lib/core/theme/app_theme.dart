import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexo_app/core/theme/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: GoogleFonts.interTextTheme(),
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      tertiary: AppColors.tertiary,
      secondary: AppColors.secondary,
    ),
  );
}

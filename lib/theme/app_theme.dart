import 'package:flutter/material.dart';
import 'package:ofma_app/theme/app_colors.dart';

class AppTheme {
  static ThemeData themeData = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.secondaryColor,
        background: const Color(0xfffcfcfc)),
    useMaterial3: true,
  );
}

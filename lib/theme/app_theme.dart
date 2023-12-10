import 'package:flutter/material.dart';
import 'package:ofma_app/theme/app_colors.dart';

class AppTheme {
  static ThemeData themeData = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.secondaryColor),
    useMaterial3: true,
  );
}

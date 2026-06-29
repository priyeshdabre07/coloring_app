// theme/typography.dart
// Defines the typography for the Tactile Play & Premium Clarity design system.
import 'package:flutter/material.dart';

class AppTypography {
  static const String heroFont = 'PlusJakartaSans';
  static const String narratorFont = 'BeVietnamPro';

  static TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(
      fontFamily: heroFont,
      fontWeight: FontWeight.w700,
      fontSize: 56,
      letterSpacing: -1.5,
    ),
    displayMedium: TextStyle(
      fontFamily: heroFont,
      fontWeight: FontWeight.w700,
      fontSize: 44,
      letterSpacing: -1.0,
    ),
    displaySmall: TextStyle(
      fontFamily: heroFont,
      fontWeight: FontWeight.w700,
      fontSize: 32,
      letterSpacing: -0.5,
    ),
    headlineLarge: TextStyle(
      fontFamily: heroFont,
      fontWeight: FontWeight.w700,
      fontSize: 28,
    ),
    headlineMedium: TextStyle(
      fontFamily: heroFont,
      fontWeight: FontWeight.w700,
      fontSize: 24,
    ),
    headlineSmall: TextStyle(
      fontFamily: heroFont,
      fontWeight: FontWeight.w700,
      fontSize: 20,
    ),
    titleLarge: TextStyle(
      fontFamily: narratorFont,
      fontWeight: FontWeight.w600,
      fontSize: 18,
    ),
    titleMedium: TextStyle(
      fontFamily: narratorFont,
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
    titleSmall: TextStyle(
      fontFamily: narratorFont,
      fontWeight: FontWeight.w500,
      fontSize: 14,
    ),
    bodyLarge: TextStyle(
      fontFamily: narratorFont,
      fontWeight: FontWeight.w400,
      fontSize: 16,
    ),
    bodyMedium: TextStyle(
      fontFamily: narratorFont,
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
    bodySmall: TextStyle(
      fontFamily: narratorFont,
      fontWeight: FontWeight.w400,
      fontSize: 12,
    ),
    labelLarge: TextStyle(
      fontFamily: heroFont,
      fontWeight: FontWeight.w600,
      fontSize: 14,
    ),
    labelMedium: TextStyle(
      fontFamily: heroFont,
      fontWeight: FontWeight.w600,
      fontSize: 12,
    ),
    labelSmall: TextStyle(
      fontFamily: heroFont,
      fontWeight: FontWeight.w600,
      fontSize: 10,
    ),
  );
}

// theme/theme.dart
// Main ThemeData builder for the Tactile Play & Premium Clarity design system.
import 'package:flutter/material.dart';

import 'borders.dart';
import 'colors.dart';
import 'typography.dart';

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.onSurface,
      primaryContainer: AppColors.primaryContainer,
      onPrimaryContainer: AppColors.onSurface,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSurface,
      secondaryContainer: AppColors.secondaryContainer,
      onSecondaryContainer: AppColors.onSurface,
      tertiary: AppColors.tertiary,
      onTertiary: AppColors.onSurface,
      tertiaryContainer: AppColors.tertiaryContainer,
      onTertiaryContainer: AppColors.onSurface,
      error: Colors.red.shade700,
      onError: Colors.white,
      errorContainer: Colors.red.shade100,
      onErrorContainer: Colors.red.shade900,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
      surfaceContainerHighest: AppColors.surfaceContainer,
      onSurfaceVariant: AppColors.onSurface,
      outline: AppColors.outlineVariant.withValues(alpha: 0.2),
      outlineVariant: AppColors.outlineVariant.withValues(alpha: 0.2),
      scrim: Colors.black.withValues(alpha: 0.1),
      shadow: AppColors.onSurface.withValues(alpha: 0.06),
      inverseSurface: AppColors.surfaceDim,
      onInverseSurface: AppColors.onSurface,
      inversePrimary: AppColors.primaryFixedDim,
      surfaceTint: AppColors.primaryContainer,
    ),
    scaffoldBackgroundColor: AppColors.surface,
    textTheme: AppTypography.textTheme,
    fontFamily: AppTypography.narratorFont,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.pressed)) {
            return AppColors.primaryFixedDim;
          }
          return AppColors.primaryContainer;
        }),
        foregroundColor: WidgetStateProperty.all(AppColors.onSurface),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(vertical: 24, horizontal: 40),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: AppBorders.xl),
        ),
        overlayColor: WidgetStateProperty.all(
          AppColors.primaryFixed.withValues(alpha: 0.12),
        ),
        elevation: WidgetStateProperty.all(0),
        animationDuration: const Duration(milliseconds: 80),
        visualDensity: VisualDensity.standard,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceContainerHighest,
      border: OutlineInputBorder(
        borderRadius: AppBorders.md,
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppBorders.md,
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
    ),
    cardTheme: CardThemeData(
      color: AppColors.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: AppBorders.lg),
      margin: const EdgeInsets.all(16),
      elevation: 0,
    ),
    dividerTheme: const DividerThemeData(
      color: Colors.transparent,
      thickness: 0,
      space: 0,
    ),
    iconTheme: IconThemeData(color: AppColors.onSurface, size: 32, opacity: 1),
    visualDensity: VisualDensity.standard,
    splashFactory: InkRipple.splashFactory,
  );
}

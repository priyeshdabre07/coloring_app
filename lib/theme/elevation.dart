// theme/elevation.dart
// Defines elevation and shadow logic for the design system.
import 'package:flutter/material.dart';

import 'colors.dart';

class AppElevation {
  // Ambient shadow for floating elements (6% opacity, 40px blur)
  static List<BoxShadow> ambientShadow = [
    BoxShadow(
      color: AppColors.onSurface.withOpacity(0.06),
      blurRadius: 40,
      offset: Offset(0, 8),
      spreadRadius: 0,
    ),
  ];

  // Ghost border for accessibility (outline-variant at 20% opacity)
  static BoxDecoration ghostBorder = BoxDecoration(
    border: Border.all(
      color: AppColors.outlineVariant.withOpacity(0.2),
      width: 2,
    ),
  );
}

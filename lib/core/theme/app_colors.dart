import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  // Brand colors from Xamariz
  static const pantone172C = Color(0xFFE94E1B); // Orange-Red
  static const pantone1505C = Color(0xFFF39200); // Orange
  static const pantone2955C = Color(0xFF274AAD); // Blue
  static const pantone715C = Color(0xFFFEFBFA); // Light peach-white background

  static const primary = pantone172C;
  static const secondary = pantone2955C;
  static const success = Color(0xFF10B981);
  static const warning = pantone1505C;
  static const danger = Color(0xFFEF4444);
  static const background = pantone715C;
  static const card = Color(0xFFFFFFFF);
  static const ink = Color(0xFF1E293B);
  static const muted = Color(0xFF64748B);
  static const border = Color(0xFFF1F5F9);

  // Gradient
  static const brandGradient = LinearGradient(
    colors: [pantone1505C, pantone172C],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

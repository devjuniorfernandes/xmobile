import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: brightness,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      error: AppColors.danger,
      surface: isDark ? const Color(0xFF0B1020) : AppColors.background,
    );

    final baseTextTheme = isDark ? ThemeData.dark().textTheme : ThemeData.light().textTheme;
    final robotoTextTheme = GoogleFonts.robotoTextTheme(baseTextTheme).copyWith(
      headlineMedium: GoogleFonts.roboto(
        textStyle: baseTextTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.w900,
          color: isDark ? Colors.white : AppColors.ink,
        ),
      ),
      headlineSmall: GoogleFonts.roboto(
        textStyle: baseTextTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.w900,
          color: isDark ? Colors.white : AppColors.ink,
        ),
      ),
      titleLarge: GoogleFonts.roboto(
        textStyle: baseTextTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w800,
          color: isDark ? Colors.white : AppColors.ink,
        ),
      ),
      titleMedium: GoogleFonts.roboto(
        textStyle: baseTextTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
          color: isDark ? Colors.white : AppColors.ink,
        ),
      ),
      bodyLarge: GoogleFonts.roboto(
        textStyle: baseTextTheme.bodyLarge?.copyWith(
          color: isDark ? Colors.white70 : AppColors.ink,
        ),
      ),
      bodyMedium: GoogleFonts.roboto(
        textStyle: baseTextTheme.bodyMedium?.copyWith(
          color: isDark ? Colors.white60 : AppColors.muted,
        ),
      ),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: isDark ? const Color(0xFF0B1020) : AppColors.background,
      textTheme: robotoTextTheme,
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        foregroundColor: isDark ? Colors.white : AppColors.ink,
        titleTextStyle: GoogleFonts.roboto(
          color: isDark ? Colors.white : AppColors.ink,
          fontSize: 20,
          fontWeight: FontWeight.w900,
        ),
        iconTheme: IconThemeData(
          color: isDark ? Colors.white : AppColors.ink,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: isDark ? const Color(0xFF111827) : AppColors.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(
            color: isDark ? const Color(0xFF263244) : AppColors.border,
            width: 1,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? const Color(0xFF111827) : Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: isDark ? const Color(0xFF263244) : AppColors.border,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: isDark ? const Color(0xFF263244) : AppColors.border,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        labelStyle: TextStyle(color: isDark ? Colors.white60 : AppColors.muted),
        floatingLabelStyle: const TextStyle(color: AppColors.primary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

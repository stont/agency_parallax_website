// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFFF6B6B),
        primary: const Color(0xFFFF6B6B),
        secondary: const Color(0xFF4ECDC4),
        background: const Color(0xFFF7F7F7),
        surface: Colors.white,
      ),
      scaffoldBackgroundColor: const Color(0xFFF7F7F7),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.poppins(
          fontSize: 96,
          fontWeight: FontWeight.w300,
        ),
        displayMedium: GoogleFonts.poppins(
          fontSize: 60,
          fontWeight: FontWeight.w300,
        ),
        displaySmall: GoogleFonts.poppins(
          fontSize: 48,
          fontWeight: FontWeight.w400,
        ),
        headlineMedium: GoogleFonts.poppins(
          fontSize: 34,
          fontWeight: FontWeight.w400,
        ),
        headlineSmall: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.w400,
        ),
        titleLarge: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF6B6B),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
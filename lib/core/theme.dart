import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF09090F),
    primaryColor: const Color(0xFF6B4DFF),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF6B4DFF),
      secondary: Color(0xFF00D1FF),
      surface: Color(0xFF1A1A24),
      background: Color(0xFF09090F),
    ),
    textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme),
    useMaterial3: true,
  );
}

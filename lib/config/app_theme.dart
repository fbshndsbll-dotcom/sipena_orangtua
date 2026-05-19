import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  //pallet
  static const Color primaryBlue = Color(0xFF0B3C6E);
  static const Color primaryBlueDark = Color(0xFF082D52);
  static const Color primaryBlueLight = Color(0xFF1565C0);
  static const Color accentOrange = Color(0xFFFF6B35);
  static const Color accentOrangeLight = Color(0xFFFF8C5A);
  static const Color backgroundGrey = Color(0xFFF0F2F5);
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textLight = Color(0xFF9CA3AF);
  static const Color successGreen = Color(0xFF22C55E);
  static const Color dangerRed = Color(0xFFEF4444);
  static const Color warningYellow = Color(0xFFF59E0B);
  static const Color infoBlue = Color(0xFF3B82F6);
  static const Color dividerColor = Color(0xFFE5E7EB);

  static ThemeData get theme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryBlue,
        primary: primaryBlue,
        secondary: accentOrange,
      ),
      scaffoldBackgroundColor: backgroundGrey,
      textTheme: GoogleFonts.poppinsTextTheme(),
      appBarTheme: AppBarTheme(
        backgroundColor: cardWhite,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.poppins(
          color: primaryBlue,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        iconTheme: const IconThemeData(color: primaryBlue),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: cardWhite,
        selectedItemColor: primaryBlue,
        unselectedItemColor: Color(0xFF9CA3AF),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontSize: 11),
      ),
      useMaterial3: false,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Paleta de cores GlucoTrack
  static const Color primaryDark = Color(0xFF1D7874);
  static const Color primaryMedium = Color(0xFF679289);
  static const Color primaryLight = Color(0xFFE8F3F1);
  static const Color backgroundLight = Color.fromARGB(255, 255, 255, 255);
  static const Color black = Color.fromARGB(255, 31, 31, 31);
  static const Color textColor = Color(0xFF5F5F5F);

  // Cores complementares
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Tema claro
  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryDark,
      brightness: Brightness.light,
      primary: primaryDark,
      secondary: primaryMedium,
      surface: Colors.white,
      onSurface: AppTheme.black,
      error: error,
    ),
    useMaterial3: true,
    scaffoldBackgroundColor: backgroundLight,

    // AppBar
    appBarTheme: AppBarTheme(
      backgroundColor: primaryDark,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.rubik(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),

    // Cards
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 4,
      shadowColor: primaryMedium.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
    ),

    // Botões principais
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryDark,
        foregroundColor: Colors.white,
        elevation: 4,
        shadowColor: primaryDark.withOpacity(0.4),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.openSans(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Botões secundários
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryDark,
        side: BorderSide(color: primaryMedium, width: 2),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.openSans(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Botões de texto
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryDark,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: GoogleFonts.openSans(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Floating Action Button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryDark,
      foregroundColor: Colors.white,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    // Inputs
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: backgroundLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryMedium, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryMedium, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryDark, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: error, width: 2),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      labelStyle: GoogleFonts.openSans(
        color: primaryMedium,
        fontWeight: FontWeight.w500,
      ),
      hintStyle: GoogleFonts.openSans(color: Colors.grey.shade500),
    ),

    // Bottom Navigation Bar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: primaryDark,
      unselectedItemColor: primaryMedium,
      selectedLabelStyle: GoogleFonts.openSans(
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      unselectedLabelStyle: GoogleFonts.openSans(
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
      elevation: 8,
      type: BottomNavigationBarType.fixed,
    ),

    // Chips
    chipTheme: ChipThemeData(
      backgroundColor: primaryLight,
      selectedColor: primaryDark,
      disabledColor: Colors.grey.shade300,
      labelStyle: GoogleFonts.openSans(
        color: primaryDark,
        fontWeight: FontWeight.w600,
      ),
      secondaryLabelStyle: GoogleFonts.openSans(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),

    // Progress Indicators
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: primaryDark,
      linearTrackColor: primaryLight,
      circularTrackColor: primaryLight,
    ),

    // Divider
    dividerTheme: DividerThemeData(
      color: primaryLight,
      thickness: 2,
      space: 24,
    ),

    // Text Theme - TÍTULOS COM RUBIK, CORPO COM OPEN SANS
    textTheme: TextTheme(
      // Displays (Títulos grandes) - RUBIK
      displayLarge: GoogleFonts.dmSans(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: primaryDark,
        letterSpacing: -0.5,
      ),
      displayMedium: GoogleFonts.dmSans(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: primaryDark,
        letterSpacing: -0.3,
      ),
      displaySmall: GoogleFonts.rubik(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: primaryDark,
        letterSpacing: -0.2,
      ),

      // Headlines (Títulos médios) - RUBIK
      headlineLarge: GoogleFonts.rubik(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Colors.grey.shade800,
      ),
      headlineMedium: GoogleFonts.rubik(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.grey.shade800,
      ),
      headlineSmall: GoogleFonts.rubik(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.grey.shade800,
      ),

      // Body (Textos de corpo) - OPEN SANS
      bodyLarge: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Colors.grey.shade700,
      ),
      bodyMedium: GoogleFonts.openSans(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.grey.shade600,
      ),
      bodySmall: GoogleFonts.openSans(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Colors.grey.shade500,
      ),

      // Labels (Botões, badges) - OPEN SANS
      labelLarge: GoogleFonts.openSans(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: primaryDark,
      ),
      labelMedium: GoogleFonts.openSans(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: primaryMedium,
      ),
      labelSmall: GoogleFonts.openSans(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: primaryMedium,
      ),
    ),

    // Icon Theme
    iconTheme: IconThemeData(color: primaryMedium, size: 24),
  );

  // Tema escuro
  static final darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryDark,
      brightness: Brightness.dark,
      primary: primaryMedium,
      secondary: primaryLight,
      surface: Color(0xFF1E1E1E),
      onSurface: Colors.white,
      error: error,
    ),
    useMaterial3: true,
    scaffoldBackgroundColor: Color(0xFF121212),

    // AppBar
    appBarTheme: AppBarTheme(
      backgroundColor: primaryMedium,
      foregroundColor: black,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.rubik(
        color: primaryLight,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: primaryLight),
    ),

    // Cards
    cardTheme: CardThemeData(
      color: Color(0xFF1E1E1E),
      elevation: 4,
      shadowColor: Colors.black54,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
    ),

    // Botões principais
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryMedium,
        foregroundColor: Colors.white,
        elevation: 4,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.openSans(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Botões secundários
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryLight,
        side: BorderSide(color: primaryMedium, width: 2),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.openSans(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Botões de texto
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryLight,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: GoogleFonts.openSans(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Floating Action Button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryMedium,
      foregroundColor: Colors.white,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    // Inputs
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFF2A2A2A),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryMedium, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryMedium, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryLight, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: error, width: 2),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      labelStyle: GoogleFonts.openSans(
        color: primaryLight,
        fontWeight: FontWeight.w500,
      ),
      hintStyle: GoogleFonts.openSans(color: Colors.grey.shade600),
    ),

    // Bottom Navigation Bar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1E1E1E),
      selectedItemColor: primaryLight,
      unselectedItemColor: primaryMedium,
      selectedLabelStyle: GoogleFonts.openSans(
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      unselectedLabelStyle: GoogleFonts.openSans(
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
      elevation: 8,
      type: BottomNavigationBarType.fixed,
    ),

    // Chips
    chipTheme: ChipThemeData(
      backgroundColor: Color(0xFF2A2A2A),
      selectedColor: primaryMedium,
      disabledColor: Colors.grey.shade800,
      labelStyle: GoogleFonts.openSans(
        color: primaryLight,
        fontWeight: FontWeight.w600,
      ),
      secondaryLabelStyle: GoogleFonts.openSans(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),

    // Progress Indicators
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: primaryMedium,
      linearTrackColor: Color(0xFF2A2A2A),
      circularTrackColor: Color(0xFF2A2A2A),
    ),

    // Divider
    dividerTheme: DividerThemeData(
      color: Color(0xFF2A2A2A),
      thickness: 2,
      space: 24,
    ),

    // Text Theme - TÍTULOS COM RUBIK, CORPO COM OPEN SANS
    textTheme: TextTheme(
      // Displays (Títulos grandes) - RUBIK
      displayLarge: GoogleFonts.rubik(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: primaryLight,
        letterSpacing: -0.5,
      ),
      displayMedium: GoogleFonts.rubik(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: primaryLight,
        letterSpacing: -0.3,
      ),
      displaySmall: GoogleFonts.rubik(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: primaryLight,
        letterSpacing: -0.2,
      ),

      // Headlines (Títulos médios) - RUBIK
      headlineLarge: GoogleFonts.rubik(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Colors.grey.shade300,
      ),
      headlineMedium: GoogleFonts.rubik(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.grey.shade300,
      ),
      headlineSmall: GoogleFonts.rubik(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.grey.shade300,
      ),

      // Body (Textos de corpo) - OPEN SANS
      bodyLarge: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Colors.grey.shade400,
      ),
      bodyMedium: GoogleFonts.openSans(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.grey.shade500,
      ),
      bodySmall: GoogleFonts.openSans(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Colors.grey.shade600,
      ),

      // Labels (Botões, badges) - OPEN SANS
      labelLarge: GoogleFonts.openSans(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: primaryLight,
      ),
      labelMedium: GoogleFonts.openSans(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: primaryMedium,
      ),
      labelSmall: GoogleFonts.openSans(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: primaryMedium,
      ),
    ),

    // Icon Theme
    iconTheme: IconThemeData(color: primaryLight, size: 24),
  );
}

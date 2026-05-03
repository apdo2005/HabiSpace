import 'package:flutter/material.dart';

class AppTheme {
  static const Color _primary = Color(0xFF1ABFB8);
  static const Color _lightBackground = Color(0xFFF0EFEA);
  static const Color _lightSurface = Color(0xFFFFFFFF);
  static const Color _darkBackground = Color(0xFF0D1B22);
  static const Color _darkSurface = Color(0xFF152028);
  static const Color _darkSurfaceAlt = Color(0xFF1C2B35);

  static ThemeData lightTheme() {
    final colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: _primary,
      onPrimary: Colors.white,
      secondary: const Color(0xFF80E8E3),
      onSecondary: const Color(0xFF014162),
      surface: _lightSurface,
      onSurface: const Color(0xFF1A1A1A),
      surfaceContainerHighest: _lightBackground,
      onSurfaceVariant: const Color(0xFF5A5A5A),
      error: const Color(0xFFE53935),
      onError: Colors.white,
      outline: const Color(0xFFDDDDDD),
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: const Color(0xFF1A1A1A),
      onInverseSurface: Colors.white,
      inversePrimary: const Color(0xFF80E8E3),
      primaryContainer: const Color(0xFFE8F8F7),
      onPrimaryContainer: const Color(0xFF014162),
      secondaryContainer: const Color(0xFFE8F8F7),
      onSecondaryContainer: const Color(0xFF014162),
      tertiaryContainer: const Color(0xFFE8F8F7),
      onTertiaryContainer: const Color(0xFF014162),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: _lightBackground,
      cardColor: _lightSurface,
      dividerColor: const Color(0xFFE0E0E0),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          backgroundColor: _lightSurface,
          foregroundColor: const Color(0xFF1A1A1A),
          shape: const CircleBorder(),
        ),
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: Color(0xFF5A5A5A),
        textColor: Color(0xFF1A1A1A),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Color(0xFF1A1A1A)),
        bodyMedium: TextStyle(color: Color(0xFF1A1A1A)),
        bodySmall: TextStyle(color: Color(0xFF5A5A5A)),
        titleLarge: TextStyle(color: Color(0xFF1A1A1A), fontWeight: FontWeight.bold),
        titleMedium: TextStyle(color: Color(0xFF1A1A1A), fontWeight: FontWeight.w600),
        labelSmall: TextStyle(color: Color(0xFF5A5A5A)),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: _lightBackground,
        foregroundColor: Color(0xFF1A1A1A),
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: _lightSurface,
        selectedItemColor: _primary,
        unselectedItemColor: const Color(0xFF888888),
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
      cardTheme: CardThemeData(
        color: _lightSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _lightSurface,
        hintStyle: const TextStyle(color: Color(0xFFAAAAAA)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _primary, width: 1.5),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFFB2F0ED),
        selectedColor: _primary,
        labelStyle: const TextStyle(color: Color(0xFF014162), fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        side: BorderSide.none,
      ),
    );
  }

  static ThemeData darkTheme() {
    final colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: _primary,
      onPrimary: Colors.white,
      secondary: const Color(0xFF1ABFB8),
      onSecondary: Colors.white,
      surface: _darkSurface,
      onSurface: const Color(0xFFE8EAED),
      surfaceContainerHighest: _darkBackground,
      onSurfaceVariant: const Color(0xFFAAB4BE),
      error: const Color(0xFFCF6679),
      onError: Colors.black,
      outline: const Color(0xFF2A3C47),
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: const Color(0xFFE8EAED),
      onInverseSurface: _darkBackground,
      inversePrimary: _primary,
      primaryContainer: _darkSurfaceAlt,
      onPrimaryContainer: const Color(0xFFE8EAED),
      secondaryContainer: _darkSurfaceAlt,
      onSecondaryContainer: const Color(0xFFE8EAED),
      tertiaryContainer: _darkSurfaceAlt,
      onTertiaryContainer: const Color(0xFFE8EAED),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: _darkBackground,
      cardColor: _darkSurfaceAlt,
      dividerColor: const Color(0xFF2A3C47),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          backgroundColor: _darkSurfaceAlt,
          foregroundColor: const Color(0xFFE8EAED),
          shape: const CircleBorder(),
        ),
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: Color(0xFFAAB4BE),
        textColor: Color(0xFFE8EAED),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Color(0xFFE8EAED)),
        bodyMedium: TextStyle(color: Color(0xFFE8EAED)),
        bodySmall: TextStyle(color: Color(0xFFAAB4BE)),
        titleLarge: TextStyle(color: Color(0xFFE8EAED), fontWeight: FontWeight.bold),
        titleMedium: TextStyle(color: Color(0xFFE8EAED), fontWeight: FontWeight.w600),
        labelSmall: TextStyle(color: Color(0xFFAAB4BE)),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: _darkBackground,
        foregroundColor: Color(0xFFE8EAED),
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: _darkSurface,
        selectedItemColor: _primary,
        unselectedItemColor: const Color(0xFF6B7F8A),
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
      cardTheme: CardThemeData(
        color: _darkSurfaceAlt,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _darkSurfaceAlt,
        hintStyle: const TextStyle(color: Color(0xFF6B7F8A)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _primary, width: 1.5),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: _darkSurfaceAlt,
        selectedColor: _primary,
        labelStyle: const TextStyle(color: Color(0xFFE8EAED), fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        side: BorderSide.none,
      ),
    );
  }
}
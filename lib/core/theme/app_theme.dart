import 'package:material_ui/material_ui.dart';

class AppTheme {
  static const seedColor = Color(0xFFFFD54F);

  static final ThemeData theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
    ),
    appBarTheme: const AppBarTheme(
      foregroundColor: seedColor,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: seedColor),
      ),
    ),
  );
}
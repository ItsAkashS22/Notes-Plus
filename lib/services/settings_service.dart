import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_plus/services/shared_preferences_services.dart';
import 'package:notes_plus/utils/custom_fonts.dart';

class SettingsService {
  final SharedPreferencesServices _sharedPreferencesServices;

  SettingsService({
    required SharedPreferencesServices sharedPreferencesServices,
  }) : _sharedPreferencesServices = sharedPreferencesServices;

  ThemeMode getThemeMode() {
    String? themeMode = _sharedPreferencesServices.getThemeMode;
    for (var value in ThemeMode.values) {
      if (value.name == themeMode) {
        return value;
      }
    }
    return ThemeMode.system;
  }

  Future<bool> updateThemeMode(ThemeMode theme) async {
    return _sharedPreferencesServices.setThemeMode(theme.name);
  }

  TextTheme getFontStyle() {
    String? fontStyle = _sharedPreferencesServices.getFontStyle;
    for (var value in textThemes.keys) {
      if (value == fontStyle) {
        return textThemes[value]!;
      }
    }
    return GoogleFonts.poppinsTextTheme();
  }

  Future<bool> updateFontStyle(String fontStyle) async {
    return _sharedPreferencesServices.setFontStyle(fontStyle);
  }
}

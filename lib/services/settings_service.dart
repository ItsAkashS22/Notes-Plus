import 'package:flutter/material.dart';

class SettingsService {
  Future<ThemeMode> themeMode() async {
    return ThemeMode.system;
  }

  Future<void> updateThemeMode(ThemeMode theme) async {}
}

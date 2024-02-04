import 'package:flutter/material.dart';
import '../services/settings_service.dart';

class SettingsController with ChangeNotifier {
  SettingsController(this._settingsService);

  final SettingsService _settingsService;
  late ThemeMode _themeMode;
  late TextTheme _textTheme;

  ThemeMode get themeMode => _themeMode;

  TextTheme get textTheme => _textTheme;

  Future<void> loadSettings() async {
    _themeMode = _settingsService.getThemeMode();
    _textTheme = _settingsService.getFontStyle();
    notifyListeners();
  }

  Future<void> updateThemeMode(ThemeMode newThemeMode) async {
    if (newThemeMode == _themeMode) return;
    if (await _settingsService.updateThemeMode(newThemeMode)) {
      _themeMode = newThemeMode;
      notifyListeners();
    }
  }

  Future<void> updateTextTheme(String fontStyle, TextTheme newTextTheme) async {
    if (newTextTheme == _textTheme) return;
    if (await _settingsService.updateFontStyle(fontStyle)) {
      _textTheme = newTextTheme;
      notifyListeners();
    }
  }
}

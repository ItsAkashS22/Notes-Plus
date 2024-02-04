import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesServices {
  final SharedPreferences _prefs;
  SharedPreferencesServices(this._prefs);

  // Keys
  final String _themeMode = 'themeMode';
  final String _fontStyle = 'fontStyle';
  final String _lastSyncedAt = 'lastSyncedAt';

  // Values
  String? themeMode;
  String? fontStyle;
  String? lastSyncedAt;

  Future<bool> setThemeMode(String value) async {
    if (await _prefs.setString(_themeMode, value)) {
      themeMode = value;
      return true;
    }
    return false;
  }

  String? get getThemeMode {
    themeMode ??= _prefs.getString(_themeMode);
    return themeMode;
  }

  Future<bool> setFontStyle(String value) async {
    if (await _prefs.setString(_fontStyle, value)) {
      fontStyle = value;
      return true;
    }
    return false;
  }

  String? get getFontStyle {
    fontStyle ??= _prefs.getString(_fontStyle);
    return fontStyle;
  }

  Future<bool> setLastSyncedAt(String value) async {
    if (await _prefs.setString(_lastSyncedAt, value)) {
      lastSyncedAt = value;
      return true;
    }
    return false;
  }

  String? get getLastSyncedAt {
    lastSyncedAt ??= _prefs.getString(_lastSyncedAt);
    return lastSyncedAt;
  }
}

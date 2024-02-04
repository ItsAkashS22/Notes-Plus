import 'package:flutter/material.dart';
import 'package:notes_plus/core/settings_controller.dart';

ThemeData lightThemeData(SettingsController settingsController) => ThemeData(
      textTheme: settingsController.textTheme,
    );

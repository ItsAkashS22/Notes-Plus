import 'package:flutter/material.dart';
import 'package:notes_plus/core/settings_controller.dart';

ThemeData darkThemeData(SettingsController settingsController) =>
    ThemeData.dark().copyWith(
      textTheme: settingsController.textTheme.copyWith(
        displayLarge: settingsController.textTheme.displayLarge
            ?.copyWith(color: ThemeData.dark().textTheme.displayLarge?.color),
        displayMedium: settingsController.textTheme.displayMedium
            ?.copyWith(color: ThemeData.dark().textTheme.displayMedium?.color),
        displaySmall: settingsController.textTheme.displaySmall
            ?.copyWith(color: ThemeData.dark().textTheme.displaySmall?.color),
        headlineLarge: settingsController.textTheme.headlineLarge
            ?.copyWith(color: ThemeData.dark().textTheme.headlineLarge?.color),
        headlineMedium: settingsController.textTheme.headlineMedium
            ?.copyWith(color: ThemeData.dark().textTheme.headlineMedium?.color),
        headlineSmall: settingsController.textTheme.headlineSmall
            ?.copyWith(color: ThemeData.dark().textTheme.headlineSmall?.color),
        titleLarge: settingsController.textTheme.titleLarge
            ?.copyWith(color: ThemeData.dark().textTheme.titleLarge?.color),
        titleMedium: settingsController.textTheme.titleMedium
            ?.copyWith(color: ThemeData.dark().textTheme.titleMedium?.color),
        titleSmall: settingsController.textTheme.titleSmall
            ?.copyWith(color: ThemeData.dark().textTheme.titleSmall?.color),
        bodyLarge: settingsController.textTheme.bodyLarge
            ?.copyWith(color: ThemeData.dark().textTheme.bodyLarge?.color),
        bodyMedium: settingsController.textTheme.bodyMedium
            ?.copyWith(color: ThemeData.dark().textTheme.bodyMedium?.color),
        bodySmall: settingsController.textTheme.bodySmall
            ?.copyWith(color: ThemeData.dark().textTheme.bodySmall?.color),
        labelLarge: settingsController.textTheme.labelLarge
            ?.copyWith(color: ThemeData.dark().textTheme.labelLarge?.color),
        labelMedium: settingsController.textTheme.labelMedium
            ?.copyWith(color: ThemeData.dark().textTheme.labelMedium?.color),
        labelSmall: settingsController.textTheme.labelSmall
            ?.copyWith(color: ThemeData.dark().textTheme.labelSmall?.color),
      ),
    );

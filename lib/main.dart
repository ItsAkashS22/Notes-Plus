import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes_plus/firebase_options.dart';

import 'app.dart';
import 'core/settings_controller.dart';
import 'services/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SettingsController settingsController =
      SettingsController(SettingsService());
  await settingsController.loadSettings();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp(settingsController: settingsController));
}

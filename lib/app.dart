import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_plus/core/datasync_controller.dart';
import 'package:notes_plus/models/note_model.dart';
import 'package:notes_plus/utils/dark_theme.dart';
import 'package:notes_plus/utils/light_theme.dart';
import 'package:notes_plus/views/home/bloc/home_bloc.dart';
import 'core/settings_controller.dart';
import 'views/home/home_view.dart';
import 'views/note/note_view.dart';
import 'views/settings/settings_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
    required this.dataSyncController,
  }) : super(key: key);

  final SettingsController settingsController;
  final DataSyncController dataSyncController;

  @override
  Widget build(BuildContext context) {
    dataSyncController.addListener(() {
      context.read<HomeBloc>().add(GetNotesEvent());
    });
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          restorationScopeId: 'app',
          theme: lightThemeData(settingsController),
          darkTheme: darkThemeData(settingsController),
          themeMode: settingsController.themeMode,
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(
                      settingsController: settingsController,
                    );
                  case NoteView.routeName:
                    return NoteView(
                      note: routeSettings.arguments as NoteModel?,
                    );
                  case HomeView.routeName:
                  default:
                    return const HomeView();
                }
              },
            );
          },
        );
      },
    );
  }
}

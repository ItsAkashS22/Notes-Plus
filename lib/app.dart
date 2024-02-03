import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_plus/repositories/user_repository.dart';
import 'package:notes_plus/views/settings/bloc/settings_bloc.dart';
import 'views/note/note_view.dart';
import 'views/home/home_view.dart';
import 'core/settings_controller.dart';
import 'views/settings/settings_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
              create: (context) => UserRepository(),
            ),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => SettingsBloc(
                  userRepository: context.read<UserRepository>(),
                )..add(
                    GetUserEvent(),
                  ),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              restorationScopeId: 'app',
              theme: ThemeData(
                textTheme: GoogleFonts.poppinsTextTheme(),
              ),
              darkTheme: ThemeData.dark(),
              themeMode: settingsController.themeMode,
              onGenerateRoute: (RouteSettings routeSettings) {
                return MaterialPageRoute<void>(
                  settings: routeSettings,
                  builder: (BuildContext context) {
                    switch (routeSettings.name) {
                      case SettingsView.routeName:
                        return SettingsView(controller: settingsController);
                      case NoteView.routeName:
                        return const NoteView();
                      case HomeView.routeName:
                      default:
                        return const HomeView();
                    }
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}

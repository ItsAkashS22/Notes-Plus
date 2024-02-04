import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_plus/core/connectivity_controller.dart';
import 'package:notes_plus/core/datasync_controller.dart';
import 'package:notes_plus/firebase_options.dart';
import 'package:notes_plus/repositories/notes_repository.dart';
import 'package:notes_plus/repositories/user_repository.dart';
import 'package:notes_plus/services/auth_services.dart';
import 'package:notes_plus/services/database_services.dart';
import 'package:notes_plus/services/firestore_services.dart';
import 'package:notes_plus/services/shared_preferences_services.dart';
import 'package:notes_plus/views/home/bloc/home_bloc.dart';
import 'package:notes_plus/views/note/bloc/note_bloc.dart';
import 'package:notes_plus/views/settings/bloc/settings_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'app.dart';
import 'core/settings_controller.dart';
import 'services/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Instantiate Firebase, Sqlite & SharedPreferences
  List futureValues = await Future.wait([
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    getDatabasesPath(),
    SharedPreferences.getInstance(),
  ]);
  final String databasePath = futureValues[1];
  final SharedPreferences sharedPreferences = futureValues[2];
  final DatabaseServices databaseServices = DatabaseServices(
    "$databasePath/notesplus.db",
  );
  final AuthServices authServices = AuthServices();
  final FirestoreService firestoreService = FirestoreService();
  final UserRepository userRepository = UserRepository(
    authServices: authServices,
  );
  final NotesRepository notesRepository = NotesRepository(
    databaseServices: databaseServices,
    firestoreService: firestoreService,
  );
  final SharedPreferencesServices sharedPreferencesServices =
      SharedPreferencesServices(
    sharedPreferences,
  );

  // Instantiate Controllers
  final SettingsController settingsController = SettingsController(
    SettingsService(sharedPreferencesServices: sharedPreferencesServices),
  );
  final ConnectivityController connectivityController =
      ConnectivityController();
  final DataSyncController dataSyncController = DataSyncController(
    notesRepository: notesRepository,
    userRepository: userRepository,
    sharedPreferencesServices: sharedPreferencesServices,
    connectivityController: connectivityController,
  );
  await Future.wait([
    settingsController.loadSettings(),
    connectivityController.startListening(),
    dataSyncController.startSync(),
  ]);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => userRepository),
        RepositoryProvider(create: (context) => notesRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SettingsBloc(
              userRepository: context.read<UserRepository>(),
              dataSyncController: dataSyncController,
            )..add(
                GetUserEvent(),
              ),
          ),
          BlocProvider(
            create: (context) => HomeBloc(
              notesRepository: context.read<NotesRepository>(),
            )..add(
                GetNotesEvent(),
              ),
          ),
          BlocProvider(
            create: (context) => NoteBloc(
              notesRepository: context.read<NotesRepository>(),
            ),
          ),
        ],
        child: MyApp(
          settingsController: settingsController,
          dataSyncController: dataSyncController,
        ),
      ),
    ),
  );
}

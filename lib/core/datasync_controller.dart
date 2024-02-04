import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:notes_plus/core/connectivity_controller.dart';
import 'package:notes_plus/models/note_model.dart';
import 'package:notes_plus/models/user_model.dart';
import 'package:notes_plus/repositories/notes_repository.dart';
import 'package:notes_plus/repositories/user_repository.dart';
import 'package:notes_plus/services/shared_preferences_services.dart';

class DataSyncController with ChangeNotifier {
  final NotesRepository notesRepository;
  final UserRepository userRepository;
  final SharedPreferencesServices sharedPreferencesServices;
  final ConnectivityController connectivityController;

  DataSyncController({
    required this.notesRepository,
    required this.userRepository,
    required this.sharedPreferencesServices,
    required this.connectivityController,
  });

  UserModel? user;
  DateTime? lastSyncedAt;

  Future<void> startSync() async {
    await sync();
    Cron().schedule(
      Schedule.parse("*/1 * * * *"),
      () async => await sync(),
    );
  }

  Future<void> sync() async {
    if (!(await _canSync())) return;
    lastSyncedAt = DateTime.tryParse(
      sharedPreferencesServices.getLastSyncedAt ?? "",
    );
    sharedPreferencesServices.setLastSyncedAt(DateTime.now().toString());
    await _syncNotes();
    notifyListeners();
  }

  Future<bool> _canSync() async {
    if (connectivityController.connectivityResult == ConnectivityResult.none) {
      return false;
    }
    user = await userRepository.getCurrentUser();
    if (user == null) {
      return false;
    }
    return true;
  }

  Future<void> _syncNotes() async {
    List<NoteModel>? localNotes = await notesRepository.getNotesToSync();
    List<NoteModel>? cloudNotes = await notesRepository.getNotesFromCloud(
      lastSyncedAt,
      user!.uid,
    );
    if (localNotes != null &&
        cloudNotes != null &&
        (localNotes.isNotEmpty || cloudNotes.isNotEmpty)) {
      for (var cloudNote in cloudNotes) {
        if (cloudNote.isDeleted) {
          await notesRepository.deleteNoteInLocal(cloudNote.id);
        } else {
          int localNoteIndex = localNotes.indexWhere(
            (note) => note.id == cloudNote.id,
          );
          if (localNoteIndex > 0 &&
              cloudNote.updatedAt
                  .isAfter(localNotes[localNoteIndex].updatedAt)) {
            await notesRepository.updateNoteInLocal(
              cloudNote,
              toBeSynced: false,
            );
          } else {
            if (!(await notesRepository.updateNoteInLocal(
              cloudNote,
              toBeSynced: false,
            ))) {
              await notesRepository.addNoteToLocal(
                cloudNote,
                toBeSynced: false,
              );
            }
          }
        }
      }

      for (var localNote in localNotes) {
        if (localNote.uid.isEmpty) {
          localNote = localNote.copyWith(
            uid: user!.uid,
          );
          if (await notesRepository.addNoteToCloud(localNote)) {
            await notesRepository.updateNoteInLocal(
              localNote,
              toBeSynced: false,
            );
          }
        } else if (lastSyncedAt != null &&
            localNote.createdAt.isAfter(lastSyncedAt!)) {
          if (await notesRepository.addNoteToCloud(localNote)) {
            await notesRepository.updateNoteInLocal(
              localNote,
              toBeSynced: false,
            );
          }
        } else {
          if (await notesRepository.updateNoteInCloud(localNote)) {
            if (localNote.isDeleted) {
              await notesRepository.deleteNoteInLocal(localNote.id);
            } else {
              await notesRepository.updateNoteInLocal(
                localNote,
                toBeSynced: false,
              );
            }
          }
        }
      }
    }
  }
}

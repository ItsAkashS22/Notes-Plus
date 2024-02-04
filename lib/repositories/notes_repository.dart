import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_plus/models/note_model.dart';
import 'package:notes_plus/services/database_services.dart';
import 'package:notes_plus/services/firestore_services.dart';
import 'package:uuid/uuid.dart';

class NotesRepository {
  final DatabaseServices _databaseServices;
  final FirestoreService _firestoreService;

  NotesRepository({
    required DatabaseServices databaseServices,
    required FirestoreService firestoreService,
  })  : _databaseServices = databaseServices,
        _firestoreService = firestoreService;

  NoteModel getNewNote() {
    return NoteModel(
      id: const Uuid().v4(),
      uid: "",
      title: "",
      content: "",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      pinned: false,
      isDeleted: false,
    );
  }

  Future<List<NoteModel>?> getNotesFromLocal() async {
    List<Map<String, dynamic>>? data = await _databaseServices.read(
      NoteModel.tableName,
      where: "isDeleted = ?",
      whereArgs: [0],
      orderBy: "pinned DESC, updatedAt DESC",
    );
    if (data == null) return null;
    return List.generate(
      data.length,
      (index) => NoteModel.fromMap(
        data[index],
      ),
    );
  }

  Future<bool> addNoteToLocal(
    NoteModel note, {
    bool toBeSynced = true,
  }) async {
    Map<String, dynamic> data = note
        .copyWith(
          createdAt: toBeSynced ? DateTime.now() : null,
          updatedAt: toBeSynced ? DateTime.now() : null,
        )
        .toMap();
    data["toBeSynced"] = toBeSynced;
    return await _databaseServices.insert(
      NoteModel.tableName,
      data,
    );
  }

  Future<bool> updateNoteInLocal(
    NoteModel note, {
    bool toBeSynced = true,
  }) async {
    Map<String, dynamic> data = note
        .copyWith(
          updatedAt: toBeSynced ? DateTime.now() : null,
        )
        .toMap();
    data["toBeSynced"] = toBeSynced;
    return await _databaseServices.update(
      NoteModel.tableName,
      data,
      where: "id = ?",
      whereArgs: [note.id],
    );
  }

  Future<bool> deleteNoteInLocal(String id) async {
    return await _databaseServices.delete(
      NoteModel.tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<List<NoteModel>?> getNotesToSync() async {
    List<Map<String, dynamic>>? data = await _databaseServices.read(
      NoteModel.tableName,
      where: "toBeSynced = ?",
      whereArgs: [1],
    );
    if (data == null) return null;
    return List.generate(
      data.length,
      (index) => NoteModel.fromMap(
        data[index],
      ),
    );
  }

  Future<List<NoteModel>?> getNotesFromCloud(
    DateTime? lastSyncedAt,
    String uid,
  ) async {
    QuerySnapshot<Object?>? data = await _firestoreService.read(
      NoteModel.tableName,
      settings: (query) {
        query = query.where("uid", isEqualTo: uid);
        if (lastSyncedAt != null) {
          query = query.where("updatedAt", isGreaterThan: lastSyncedAt);
        }
        return query;
      },
    );
    if (data == null) return null;
    return List.generate(
      data.docs.length,
      (index) => NoteModel.fromMap(
        data.docs[index].data() as Map<String, dynamic>,
      ),
    );
  }

  Future<bool> addNoteToCloud(NoteModel note) async {
    return await _firestoreService.create(
      NoteModel.tableName,
      note.id,
      note.toMap(),
    );
  }

  Future<bool> updateNoteInCloud(NoteModel note) async {
    return await _firestoreService.update(
      NoteModel.tableName,
      note.id,
      note.toMap(),
    );
  }
}

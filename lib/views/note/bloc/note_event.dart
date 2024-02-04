// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'note_bloc.dart';

sealed class NoteEvent {}

class SetNoteEvent extends NoteEvent {
  final NoteModel? note;
  final bool isNewNote;

  SetNoteEvent({
    this.note,
    required this.isNewNote,
  });
}

class SaveNoteEvent extends NoteEvent {
  final String title;
  final String content;

  SaveNoteEvent({
    required this.title,
    required this.content,
  });
}

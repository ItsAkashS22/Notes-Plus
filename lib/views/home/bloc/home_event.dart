part of 'home_bloc.dart';

sealed class HomeEvent {}

class GetNotesEvent extends HomeEvent {}

class SearchNotesEvent extends HomeEvent {
  final String key;

  SearchNotesEvent({
    required this.key,
  });
}

class PinNoteEvent extends HomeEvent {
  NoteModel note;
  PinNoteEvent({
    required this.note,
  });
}

class DeleteNoteEvent extends HomeEvent {
  NoteModel note;
  DeleteNoteEvent({
    required this.note,
  });
}

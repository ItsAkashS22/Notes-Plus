import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_plus/models/note_model.dart';
import 'package:notes_plus/repositories/notes_repository.dart';
part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NotesRepository notesRepository;

  NoteBloc({required this.notesRepository}) : super(NoteLoadingState()) {
    on<SetNoteEvent>(_getNoteEvent);
    on<SaveNoteEvent>(_saveNoteEvent);
  }

  FutureOr<void> _getNoteEvent(
    SetNoteEvent event,
    Emitter<NoteState> emit,
  ) {
    emit(
      NoteLoadingState(),
    );
    emit(
      NoteLoadedState(
        note: event.isNewNote ? notesRepository.getNewNote() : event.note!,
        isNewNote: event.isNewNote,
      ),
    );
  }

  Future<void> _saveNoteEvent(
      SaveNoteEvent event, Emitter<NoteState> emit) async {
    if (state is NoteLoadedState) {
      NoteLoadedState noteLoadedState = state as NoteLoadedState;
      bool savedSuccessfully = false;
      NoteModel newNote = noteLoadedState.note.copyWith(
        title: event.title,
        content: event.content,
      );
      if (noteLoadedState.isNewNote) {
        savedSuccessfully = await notesRepository.addNoteToLocal(newNote);
      } else {
        savedSuccessfully = await notesRepository.updateNoteInLocal(newNote);
      }
      emit(
        noteLoadedState.copyWith(
          savedSuccessfully: savedSuccessfully,
        ),
      );
    }
  }
}

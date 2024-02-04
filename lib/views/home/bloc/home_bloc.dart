import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_plus/models/note_model.dart';
import 'package:notes_plus/repositories/notes_repository.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final NotesRepository notesRepository;
  HomeBloc({
    required this.notesRepository,
  }) : super(HomeLoadingState()) {
    on<GetNotesEvent>(_getNotesEvent);
    on<SearchNotesEvent>(_searchNotesEvent);
    on<PinNoteEvent>(_pinNoteEvent);
    on<DeleteNoteEvent>(_deleteNoteEvent);
  }

  Future<void> _getNotesEvent(
    GetNotesEvent event,
    Emitter<HomeState> emit,
  ) async {
    List<NoteModel>? notes = await notesRepository.getNotesFromLocal();
    if (notes == null) {
      emit(
        HomeErrorState(
          errorMessage: "Failed to load your notes",
        ),
      );
    } else {
      if (state is HomeLoadedState) {
        emit(
          (state as HomeLoadedState).copyWith(
            notes: notes,
          ),
        );
      } else {
        emit(
          HomeLoadedState(
            notes: notes,
            searchController: TextEditingController(),
          ),
        );
      }
    }
  }

  Future<void> _searchNotesEvent(
    SearchNotesEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is HomeLoadedState) {
      emit(
        (state as HomeLoadedState).copyWith(
          filteredNotes: [...(state as HomeLoadedState).notes]
              .takeWhile(
                (value) =>
                    value.title.toLowerCase().trim().contains(event.key) ||
                    value.content.toLowerCase().trim().contains(event.key),
              )
              .toList(),
        ),
      );
    }
  }

  Future<void> _pinNoteEvent(
    PinNoteEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (await notesRepository.updateNoteInLocal(event.note.copyWith(
      pinned: !event.note.pinned,
    ))) {
      add(GetNotesEvent());
    }
  }

  Future<void> _deleteNoteEvent(
    DeleteNoteEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (await notesRepository.updateNoteInLocal(event.note.copyWith(
      isDeleted: true,
    ))) {
      add(GetNotesEvent());
    }
  }
}

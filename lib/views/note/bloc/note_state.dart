part of 'note_bloc.dart';

sealed class NoteState extends Equatable {}

class NoteLoadingState extends NoteState {
  @override
  List<Object?> get props => [];
}

class NoteLoadedState extends NoteState {
  final NoteModel note;
  final bool isNewNote;
  final bool? savedSuccessfully;

  NoteLoadedState({
    required this.note,
    required this.isNewNote,
    this.savedSuccessfully,
  });

  NoteLoadedState copyWith({
    NoteModel? note,
    bool? isNewNote,
    bool? savedSuccessfully,
  }) {
    return NoteLoadedState(
      note: note ?? this.note,
      isNewNote: isNewNote ?? this.isNewNote,
      savedSuccessfully: savedSuccessfully,
    );
  }

  @override
  List<Object?> get props => [
        note,
        isNewNote,
        savedSuccessfully,
      ];
}

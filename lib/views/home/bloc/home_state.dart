part of 'home_bloc.dart';

sealed class HomeState extends Equatable {}

final class HomeLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

final class HomeLoadedState extends HomeState {
  final List<NoteModel> notes;
  final TextEditingController searchController;
  final List<NoteModel> filteredNotes;

  HomeLoadedState({
    required this.notes,
    required this.searchController,
    this.filteredNotes = const [],
  });

  HomeLoadedState copyWith({
    List<NoteModel>? notes,
    List<NoteModel>? filteredNotes,
  }) {
    return HomeLoadedState(
      notes: notes ?? this.notes,
      filteredNotes: filteredNotes ?? this.filteredNotes,
      searchController: searchController,
    );
  }

  @override
  List<Object> get props => [
        notes,
        filteredNotes,
      ];
}

final class HomeErrorState extends HomeState {
  final String errorMessage;

  HomeErrorState({
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [
        errorMessage,
      ];
}

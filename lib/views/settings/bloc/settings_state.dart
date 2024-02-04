part of 'settings_bloc.dart';

sealed class SettingsState extends Equatable {}

final class SettingsLoadingState extends SettingsState {
  @override
  List<Object?> get props => [];
}

final class SettingsLoadedState extends SettingsState {
  final UserModel? user;
  SettingsLoadedState({required this.user});
  @override
  List<Object?> get props => [
        user,
      ];
}

final class SettingsErrorState extends SettingsState {
  final String errorMessage;

  SettingsErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [
        errorMessage,
      ];
}

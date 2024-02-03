part of 'settings_bloc.dart';

sealed class SettingsState {}

final class SettingsLoading extends SettingsState {}

final class SettingsLoaded extends SettingsState {
  final UserModel? user;
  SettingsLoaded({required this.user});
}

final class SettingsError extends SettingsState {
  final String errorMessage;

  SettingsError({required this.errorMessage});
}

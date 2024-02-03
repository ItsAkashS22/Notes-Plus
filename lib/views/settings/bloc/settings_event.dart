part of 'settings_bloc.dart';

sealed class SettingsEvent {}

class GetUserEvent extends SettingsEvent {}

class SignInWithGoogleEvent extends SettingsEvent {}

class SignOutEvent extends SettingsEvent {}

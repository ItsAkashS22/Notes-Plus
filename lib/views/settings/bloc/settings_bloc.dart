// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_plus/core/datasync_controller.dart';

import 'package:notes_plus/models/user_model.dart';
import 'package:notes_plus/repositories/user_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final UserRepository userRepository;
  final DataSyncController dataSyncController;

  SettingsBloc({
    required this.dataSyncController,
    required this.userRepository,
  }) : super(SettingsLoadingState()) {
    on<GetUserEvent>(_getUserEvent);
    on<SignInWithGoogleEvent>(_signInWithGoogleEvent);
    on<SignOutEvent>(_signOutEvent);
  }

  Future<void> _getUserEvent(
    GetUserEvent event,
    Emitter<SettingsState> emit,
  ) async {
    UserModel? user = await userRepository.getCurrentUser();
    emit(SettingsLoadedState(user: user));
  }

  Future<void> _signInWithGoogleEvent(
    SignInWithGoogleEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(SettingsLoadingState());
    UserModel? user = await userRepository.signInWithGoogle();
    if (user == null) {
      emit(
        SettingsErrorState(errorMessage: "Sign In Failed"),
      );
    } else {
      await dataSyncController.sync();
      emit(
        SettingsLoadedState(user: user),
      );
    }
  }

  Future<void> _signOutEvent(
    SignOutEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(SettingsLoadingState());
    await dataSyncController.sync();
    bool signedOut = await userRepository.signOut();
    if (signedOut) {
      emit(SettingsLoadedState(user: null));
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_plus/views/settings/bloc/settings_bloc.dart';
import '../../core/settings_controller.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key, required this.controller});

  static const String routeName = '/settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          Card(
            margin: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            child: BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                if (state is SettingsLoading) {
                  return ListTile(
                    leading: Container(
                      clipBehavior: Clip.antiAlias,
                      width: 32,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: const LinearProgressIndicator(
                        minHeight: 32,
                        color: Colors.grey,
                      ),
                    ),
                    title: LinearProgressIndicator(
                      minHeight: 8,
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    subtitle: LinearProgressIndicator(
                      minHeight: 4,
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  );
                }
                if (state is SettingsError) {
                  return ListTile(
                    leading: const Icon(Icons.error_outline_rounded),
                    title: const Text("Something went wrong"),
                    subtitle: Text(state.errorMessage),
                  );
                }
                if (state is SettingsLoaded && state.user != null) {
                  return ListTile(
                    leading: Container(
                      clipBehavior: Clip.antiAlias,
                      width: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(state.user!.photoUrl),
                    ),
                    title: Text(state.user!.displayName),
                    subtitle: Text(state.user!.email),
                    trailing: Transform.translate(
                      offset: const Offset(20, 0),
                      child: IconButton(
                        onPressed: () {
                          context.read<SettingsBloc>().add(SignOutEvent());
                        },
                        icon: const Icon(Icons.logout_rounded),
                      ),
                    ),
                  );
                }
                return ListTile(
                  onTap: () {
                    context.read<SettingsBloc>().add(SignInWithGoogleEvent());
                  },
                  leading: SizedBox(
                    width: 32,
                    child: Image.asset("assets/google.png"),
                  ),
                  title: const Text("Sync your notes to cloud"),
                  subtitle: const Text("Continue with Google"),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                  ),
                );
              },
            ),
          ),
          const Divider(
            height: 40,
          ),
          const Text(
            "Theme",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          SegmentedButton<ThemeMode>(
            onSelectionChanged: (mode) => controller.updateThemeMode(
              mode.first,
            ),
            multiSelectionEnabled: false,
            emptySelectionAllowed: false,
            segments: const [
              ButtonSegment(
                value: ThemeMode.light,
                icon: Icon(Icons.light_mode_rounded),
                label: Text("Light"),
              ),
              ButtonSegment(
                icon: Icon(Icons.computer_rounded),
                value: ThemeMode.system,
                label: Text("System"),
              ),
              ButtonSegment(
                icon: Icon(Icons.dark_mode_rounded),
                value: ThemeMode.dark,
                label: Text("Dark"),
              ),
            ],
            selected: {controller.themeMode},
          ),
        ],
      ),
    );
  }
}

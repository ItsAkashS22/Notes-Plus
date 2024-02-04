import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_plus/models/note_model.dart';
import 'package:notes_plus/views/home/bloc/home_bloc.dart';
import 'package:notes_plus/views/note/bloc/note_bloc.dart';
import 'package:notes_plus/views/note/note_view.dart';
import 'package:notes_plus/views/settings/bloc/settings_bloc.dart';
import 'package:notes_plus/widgets/note_card.dart';
import '../settings/settings_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          context.read<NoteBloc>().add(
                SetNoteEvent(
                  isNewNote: true,
                ),
              );
          Navigator.pushNamed(
            context,
            NoteView.routeName,
          );
        },
        child: const Icon(
          Icons.add_rounded,
        ),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _buildAppBar(state),
            _buildNotes(state),
          ],
        );
      },
    );
  }

  Widget _buildAppBar(HomeState homeState) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        bool showTurnOnSync =
            state is! SettingsLoadedState || state.user == null;
        bool showFlexibleRegion =
            homeState is HomeLoadedState && homeState.notes.isNotEmpty;
        return SliverAppBar(
          pinned: true,
          leading: Center(
            child: Image.asset(
              "assets/logo.png",
              width: 28,
            ),
          ),
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Notes',
                style: GoogleFonts.sriracha(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'Plus',
                style: GoogleFonts.dancingScript(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
              ),
              child: AspectRatio(
                aspectRatio: 1,
                child: Hero(
                  tag: "settings-tag",
                  child: Card(
                    elevation: 0,
                    margin: EdgeInsets.zero,
                    clipBehavior: Clip.antiAlias,
                    shape: const CircleBorder(),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          SettingsView.routeName,
                        );
                      },
                      child: BlocBuilder<SettingsBloc, SettingsState>(
                        builder: (context, state) {
                          if (state is SettingsLoadedState &&
                              state.user != null) {
                            return Container(
                                clipBehavior: Clip.antiAlias,
                                margin: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.network(state.user!.photoUrl));
                          }
                          return const Icon(
                            Icons.manage_accounts_rounded,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
          ],
          expandedHeight: showFlexibleRegion
              ? kToolbarHeight + (showTurnOnSync ? 118 : 60)
              : null,
          flexibleSpace: showFlexibleRegion
              ? FlexibleSpaceBar(
                  background: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Card(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        child: TextField(
                          controller: homeState.searchController,
                          onChanged: (value) {
                            context.read<HomeBloc>().add(
                                  SearchNotesEvent(
                                    key: value.toLowerCase().trim(),
                                  ),
                                );
                          },
                          decoration: const InputDecoration(
                            hintText: "Search for title or note...",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(12),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      showTurnOnSync
                          ? Card(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              clipBehavior: Clip.antiAlias,
                              child: InkWell(
                                onTap: () {
                                  context
                                      .read<SettingsBloc>()
                                      .add(SignInWithGoogleEvent());
                                },
                                child: Container(
                                  height: 48,
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: const Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Turn on sync"),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 16,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      showTurnOnSync
                          ? const SizedBox(
                              height: 12,
                            )
                          : const SizedBox(),
                    ],
                  ),
                )
              : null,
        );
      },
    );
  }

  Widget _buildNotes(HomeState homeState) {
    if (homeState is HomeLoadingState) {
      return const SliverFillRemaining(
        hasScrollBody: false,
        child: CupertinoActivityIndicator(),
      );
    }
    if (homeState is HomeErrorState) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Opacity(
          opacity: 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_rounded,
                size: 40,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                homeState.errorMessage,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      );
    }
    if (homeState is HomeLoadedState) {
      List<NoteModel> notes = homeState.searchController.value.text.isEmpty
          ? homeState.notes
          : homeState.filteredNotes;
      return notes.isEmpty
          ? SliverFillRemaining(
              hasScrollBody: false,
              child: Opacity(
                opacity: 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.notes_rounded,
                      size: 40,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      homeState.searchController.value.text.isEmpty
                          ? "No Notes Written Yet"
                          : "No Notes Founds",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : SliverPadding(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
              sliver: SliverMasonryGrid.count(
                crossAxisCount: 2,
                childCount: notes.length,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                itemBuilder: (BuildContext context, int index) {
                  return NoteCard(
                    note: notes[index],
                  );
                },
              ),
            );
    }
    return const SizedBox();
  }
}

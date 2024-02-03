import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_plus/views/note/note_view.dart';
import 'package:notes_plus/views/settings/bloc/settings_bloc.dart';
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
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Stack(
              alignment: Alignment.topRight,
              children: [
                Text(
                  'Notes',
                  style: GoogleFonts.dancingScript(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Transform.translate(
                  offset: const Offset(12, -12),
                  child: Text(
                    '+',
                    style: GoogleFonts.dancingScript(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Card(
                    elevation: 0,
                    margin: EdgeInsets.zero,
                    clipBehavior: Clip.antiAlias,
                    shape: const CircleBorder(),
                    child: InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.add_rounded,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Card(
                    elevation: 0,
                    margin: EdgeInsets.zero,
                    clipBehavior: Clip.antiAlias,
                    shape: const CircleBorder(),
                    child: InkWell(
                      onTap: () {
                        Navigator.restorablePushNamed(
                            context, SettingsView.routeName);
                      },
                      child: BlocBuilder<SettingsBloc, SettingsState>(
                        builder: (context, state) {
                          if (state is SettingsLoaded && state.user != null) {
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
              const SizedBox(
                width: 12,
              ),
            ],
            expandedHeight: kBottomNavigationBarHeight + 118, //58,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Card(
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search for title, note",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(12),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
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
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  ),
                  const SizedBox(
                    height: 4,
                  )
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverMasonryGrid.count(
              crossAxisCount: 2,
              childCount: 10,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              itemBuilder: (BuildContext context, int index) {
                return Hero(
                  tag: index,
                  child: Card(
                    margin: EdgeInsets.zero,
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () {
                        Navigator.restorablePushNamed(
                          context,
                          NoteView.routeName,
                          arguments: index,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              "Title - Lorem Impus, this is a note of the year.",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              "Lorem Impus, this is a note of the year. " *
                                  (index + 1),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 4,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            const Divider(
                              height: 0,
                              thickness: 1,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "12 September 2023",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.circular(4),
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            TextButton(
                                              onPressed: () {},
                                              child: const Text("Pin"),
                                            ),
                                            const Divider(),
                                            TextButton(
                                              onPressed: () {},
                                              child: const Text("Delete"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  child: const SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: Icon(Icons.more_horiz_rounded)),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

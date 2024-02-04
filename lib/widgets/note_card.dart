import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes_plus/models/note_model.dart';
import 'package:notes_plus/views/home/bloc/home_bloc.dart';
import 'package:notes_plus/views/note/note_view.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.note,
  });

  final NoteModel note;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: note.id,
      child: Card(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              NoteView.routeName,
              arguments: note,
            );
          },
          onLongPress: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.read<HomeBloc>().add(
                              PinNoteEvent(note: note),
                            );
                        Navigator.pop(context);
                      },
                      child: Text(note.pinned ? "Unpin" : "Pin"),
                    ),
                    const Divider(),
                    TextButton(
                      onPressed: () {
                        context.read<HomeBloc>().add(
                              DeleteNoteEvent(note: note),
                            );
                        Navigator.pop(context);
                      },
                      child: const Text("Delete"),
                    ),
                  ],
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  note.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  note.content,
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
                    Text(
                      (DateFormat.yMd().format(DateTime.now()) ==
                              DateFormat.yMd().format(note.updatedAt))
                          ? "Today, ${DateFormat.jm().format(note.updatedAt)}"
                          : DateFormat.yMMMMd().format(note.updatedAt),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    note.pinned
                        ? const Icon(
                            Icons.vertical_align_top_rounded,
                            size: 12,
                          )
                        : const SizedBox(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

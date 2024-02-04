import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes_plus/models/note_model.dart';
import 'package:notes_plus/views/home/bloc/home_bloc.dart';
import 'package:notes_plus/views/note/bloc/note_bloc.dart';

class NoteView extends StatelessWidget {
  NoteView({
    Key? key,
    required this.note,
  }) : super(key: key);

  final NoteModel? note;

  static const routeName = '/note';

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.read<NoteBloc>().add(
          SetNoteEvent(
            note: note,
            isNewNote: note == null,
          ),
        );
    if (note != null) {
      _titleController.value = TextEditingValue(text: note!.title);
      _contentController.value = TextEditingValue(text: note!.content);
    }
    return BlocListener<NoteBloc, NoteState>(
      listener: (context, state) {
        if (state is NoteLoadedState) {
          if (state.savedSuccessfully == true) {
            context.read<HomeBloc>().add(GetNotesEvent());
            Navigator.pop(context);
          }
          if (state.savedSuccessfully == false) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Something went wrong"),
              ),
            );
          }
        }
      },
      child: Hero(
        tag: note == null ? "" : note!.id,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  context.read<NoteBloc>().add(
                        SaveNoteEvent(
                          title: _titleController.value.text,
                          content: _contentController.value.text,
                        ),
                      );
                },
                icon: const Icon(
                  Icons.check_rounded,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: TextField(
                    controller: _titleController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Title",
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: note == null
                      ? const SizedBox()
                      : Text(
                          DateFormat.yMMMEd().format(note!.updatedAt),
                        ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: TextField(
                    controller: _contentController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Start Typing...",
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class NoteView extends StatelessWidget {
  const NoteView({super.key});

  static const routeName = '/note';

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: ModalRoute.of(context)!.settings.arguments!,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.info_outline_rounded,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.color_lens_rounded,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.check_rounded,
              ),
            ),
          ],
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Title",
                  ),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Content",
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

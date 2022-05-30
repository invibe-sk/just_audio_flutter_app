import 'package:flutter/material.dart';
import 'package:knihy_audio_app_new/models/book.dart';
import 'package:knihy_audio_app_new/screens/book.dart';
import 'package:knihy_audio_app_new/widgets/books/list/book_list_image.dart';
import 'package:knihy_audio_app_new/widgets/elevated_container.dart';
import 'package:knihy_audio_app_new/widgets/books/list/book_list_title.dart';

class BookListItem extends StatelessWidget {
  final Book book;

  const BookListItem({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          BookScreen.routeName,
          arguments: BookScreenArguments(book: book),
        );
      },
      child: ElevatedContainer(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              BookListImage(imageUrl: book.imageUrl),
              const SizedBox(width: 15),
              BookListTitle(name: book.name, author: book.author),
              const Align(alignment: Alignment.centerRight, child: Icon(Icons.chevron_right)),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:knihy_audio_app_new/models/book.dart';
import 'package:knihy_audio_app_new/widgets/books/list/book_list_item.dart';

class BooksListView extends StatelessWidget {
  final List<Book> books;

  const BooksListView({Key? key, required this.books}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (_, index) => BookListItem(book: books[index]),
      itemCount: books.length,
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:knihy_audio_app_new/models/book.dart';
import 'package:knihy_audio_app_new/services/api.dart';
import 'package:knihy_audio_app_new/services/service_locator.dart';
import 'package:knihy_audio_app_new/widgets/books/list/book_list_view.dart';

class OtherBooksScreen extends StatefulWidget {
  const OtherBooksScreen({Key? key}) : super(key: key);

  @override
  State<OtherBooksScreen> createState() => _OtherBooksScreenState();
}

class _OtherBooksScreenState extends State<OtherBooksScreen> {
  List<Book> books = [];
  bool _loading = true;
  final Api api = getIt<Api>();

  @override
  void initState() {
    _getOtherBooks();
    super.initState();
  }

  void _getOtherBooks() async {
    setState(() {
      _loading = true;
    });

    http.Response res = await api.otherBooksRequest();

    if (res.statusCode == 200) {
      List booksJson = jsonDecode(res.body)['data'];

      books.clear();

      for (Map<String, dynamic> element in booksJson) {
        books.add(Book.fromJson(element));
      }

      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const Center(child: CircularProgressIndicator())
        : BooksListView(books: books);
  }
}

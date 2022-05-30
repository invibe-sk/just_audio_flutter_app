import 'package:flutter/material.dart';
import 'package:knihy_audio_app_new/screens/books/other_books.dart';
import 'package:knihy_audio_app_new/screens/login.dart';
import 'package:knihy_audio_app_new/services/api.dart';
import 'package:knihy_audio_app_new/services/service_locator.dart';
import 'books/my_books.dart';

class BooksScreen extends StatefulWidget {
  static const routeName = '/books';

  const BooksScreen({Key? key}) : super(key: key);

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  int _pageSelectedIndex = 0;
  final Api api = getIt<Api>();

  final List<Widget> _pages = [
    const MyBooksScreen(),
    const OtherBooksScreen(),
  ];

  final List<String> _titles = [
    "Moje knihy",
    "Ostatné knihy",
  ];

  void _logout(BuildContext context) async {
    await api.logoutRequest();
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_pageSelectedIndex]),
      ),
      body: _pages[_pageSelectedIndex],
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.power_settings_new),
        onPressed: () => _logout(context),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageSelectedIndex,
        onTap: (index) {
          setState(() {
            _pageSelectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.headset), label: _titles[0]),
          BottomNavigationBarItem(icon: const Icon(Icons.image), label: _titles[1]),
        ],
      ),
    );
  }
}

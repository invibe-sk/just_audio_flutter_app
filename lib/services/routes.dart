import 'package:flutter/material.dart';
import 'package:knihy_audio_app_new/screens/book.dart';
import 'package:knihy_audio_app_new/screens/loading.dart';
import 'package:knihy_audio_app_new/screens/player.dart';

import '../screens/books.dart';
import '../screens/login.dart';

class Routes {
  static Map<String, Widget Function(BuildContext context)> get() {
    return {
      LoadingScreen.routeName: (_) => const LoadingScreen(),
      LoginScreen.routeName: (_) => const LoginScreen(),
      BooksScreen.routeName: (_) => const BooksScreen(),
      BookScreen.routeName: (_) => const BookScreen(),
      PlayerScreen.routeName: (_) => const PlayerScreen(),
    };
  }
}
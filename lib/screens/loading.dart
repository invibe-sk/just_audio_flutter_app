import 'package:flutter/material.dart';
import 'package:knihy_audio_app_new/screens/books.dart';
import 'package:knihy_audio_app_new/screens/login.dart';
import 'package:knihy_audio_app_new/services/api.dart';

class LoadingScreen extends StatefulWidget {
  static const routeName = '/';

  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500), _checkIfLoggedIn);
    super.initState();
  }

  void _checkIfLoggedIn() async {
    if (await Api().getToken() != null) {
      Navigator.of(context).pushReplacementNamed(BooksScreen.routeName);
    } else {
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

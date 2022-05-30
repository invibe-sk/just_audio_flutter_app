import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knihy_audio_app_new/screens/books.dart';
import 'package:knihy_audio_app_new/services/login_screen_state.dart';
import 'package:knihy_audio_app_new/services/service_locator.dart';
import 'package:knihy_audio_app_new/services/api.dart';
import 'package:knihy_audio_app_new/widgets/login/email_input_field.dart';
import 'package:knihy_audio_app_new/widgets/login/forgot_password_button.dart';
import 'package:knihy_audio_app_new/widgets/login/login_button.dart';
import 'package:knihy_audio_app_new/widgets/login/logo_and_text_inputs.dart';
import 'package:knihy_audio_app_new/widgets/login/password_input_field.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  static String routeName = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;
  final loginScreenState = getIt<LoginScreenState>();
  final Api api = getIt<Api>();

  Future<http.Response> _loginRequest() => Future.delayed(
        const Duration(milliseconds: 500),
        () => api.loginRequest(email: email, password: password),
      );

  void _setLoading(BuildContext context, {required bool value}) =>
      loginScreenState.setLoading(value);

  void _showAlert(BuildContext context, {required String message}) {
    String errorString = "Chyba";

    void onPressed() {
      Navigator.of(context).pop();
    }

    TextButton textButton(void Function() onPressed) =>
        TextButton(onPressed: onPressed, child: const Text("Zavrieť"));

    if (Platform.isIOS) {
      showCupertinoDialog(
        barrierDismissible: true,
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: Text(errorString),
          content: Text(message),
          actions: [textButton(onPressed)],
        ),
      );
    } else {
      showDialog(
        barrierDismissible: true,
        context: context,
        builder: (_) => AlertDialog(
          title: Text(errorString),
          content: Text(message),
          actions: [textButton(onPressed)],
        ),
      );
    }
  }

  void _login(BuildContext context) async {
    _setLoading(context, value: true);

    // sets the token to secure storage if successful
    http.Response res = await _loginRequest();

    if (!mounted) return;
    _setLoading(context, value: false);

    if (res.statusCode == 200) {
      Navigator.of(context).pushReplacementNamed(BooksScreen.routeName);
    } else if (res.statusCode == 422) {
      _showAlert(
        context,
        message: jsonDecode(res.body)['error'] ?? "Neznáma chyba",
      );
    } else {
      _showAlert(
        context,
        message: "Neznáma chyba",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LogoAndTextInputs(
              children: [
                const Text("Vitajte v aplikácií", style: TextStyle(fontSize: 18)),
                const SizedBox(height: 20),
                Image.network('https://knihy.audio/static/logo-black-png.png'),
                const SizedBox(height: 40),
                EmailInputField(onChanged: (value) => email = value),
                const SizedBox(height: 40),
                PasswordInputField(onChanged: (value) => password = value),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LoginButton(onPressed: () => _login(context)),
                  const SizedBox(height: 10),
                  const ForgotPasswordButton(),
                  const SizedBox(height: 100)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

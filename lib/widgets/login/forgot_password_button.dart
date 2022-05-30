import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({Key? key}) : super(key: key);

  void _launchUrl(Uri url) async {
    if (!await launchUrl(url)) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        foregroundColor:
            MaterialStateProperty.all(Theme.of(context).primaryColor),
      ),
      onPressed: () =>
          _launchUrl(Uri.parse('https://knihy.audio/zabubnute-heslo')),
      child: const Text(
        "Zabudnuté heslo",
      ),
    );
  }
}

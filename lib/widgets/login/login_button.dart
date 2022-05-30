import 'package:flutter/material.dart';
import 'package:knihy_audio_app_new/services/login_screen_state.dart';
import 'package:knihy_audio_app_new/services/service_locator.dart';

class LoginButton extends StatelessWidget {
  final void Function()? onPressed;

  const LoginButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginScreenState = getIt<LoginScreenState>();

    return SizedBox(
      height: 67,
      child: ElevatedButton(
        onPressed: onPressed,
        child: ValueListenableBuilder(
          valueListenable: loginScreenState.loading,
          builder: (_, bool loading, __) {
            return buildButtonChild(loading);
          },
        ),
      ),
    );
  }

  Widget buildButtonChild(bool loading) {
    if (loading) {
      return const SizedBox(
        width: 25,
        height: 25,
        child: CircularProgressIndicator(color: Colors.white),
      );
    } else {
      return const Text("Prihlásiť sa");
    }
  }
}

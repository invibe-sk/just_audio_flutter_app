import 'package:flutter/material.dart';

class PasswordInputField extends StatelessWidget {
  const PasswordInputField({Key? key, this.onChanged}) : super(key: key);

  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      onChanged: onChanged,
      decoration: const InputDecoration(
        labelText: 'Heslo',
        hintText: '', // for height
      ),
    );
  }
}

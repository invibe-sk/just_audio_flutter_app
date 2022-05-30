import 'package:flutter/material.dart';

class EmailInputField extends StatelessWidget {
  const EmailInputField({Key? key, this.onChanged}) : super(key: key);

  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: const InputDecoration(
        labelText: 'E-mailová adresa',
        hintText: '', // for height
      ),
    );
  }
}

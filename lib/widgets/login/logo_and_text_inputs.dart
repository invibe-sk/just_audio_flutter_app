import 'package:flutter/material.dart';

class LogoAndTextInputs extends StatelessWidget {

  final List<Widget> children;

  const LogoAndTextInputs({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * .5),
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: MediaQuery.of(context).viewInsets.bottom < 200
            ? Alignment.bottomCenter // if keyboard is shown
            : Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
}

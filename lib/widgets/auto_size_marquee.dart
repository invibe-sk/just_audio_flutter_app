import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class AutoSizeMarquee extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  const AutoSizeMarquee({Key? key, required this.text, this.style, this.textAlign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: style,
      maxLines: 1,
      textAlign: textAlign,
      minFontSize: style?.fontSize ?? 18,
      maxFontSize: style?.fontSize ?? 18,
      overflowReplacement: Marquee(
        blankSpace: 20.0,
        pauseAfterRound: const Duration(seconds: 1, milliseconds: 500),
        text: text,
        style: style,
      ),
    );
  }
}

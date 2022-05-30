import 'dart:math' as math;
import 'package:flutter/material.dart';

class SkipSecondsIconButton extends StatelessWidget {
  final void Function()? onPressed;
  final bool flipped;

  const SkipSecondsIconButton({
    Key? key,
    this.onPressed,
    this.flipped = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: Colors.transparent,
      onPressed: onPressed,
      icon: Stack(
        alignment: Alignment.center,
        children: [
          buildIcon(),
          Align(
            alignment: flipped ? Alignment.bottomLeft : Alignment.bottomRight,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                  height: 17,
                  width: 17,
                ),
                const Text(
                  "15",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIcon() {
    if (flipped) {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(math.pi),
        child: const Icon(
          Icons.refresh,
          color: Colors.black,
        ),
      );
    } else {
      return const Icon(Icons.refresh, color: Colors.black);
    }
  }
}

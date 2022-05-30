import 'package:flutter/material.dart';

class ElevatedContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Color? color;

  const ElevatedContainer({Key? key, required this.child, this.padding, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: child,
    );
  }
}

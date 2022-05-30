import 'package:flutter/material.dart';
import 'package:knihy_audio_app_new/widgets/elevated_container.dart';

class BookEntities extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const BookEntities({Key? key, required this.title, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.only(bottom: 5, left: 5),
              child: Text(
                title,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: children,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

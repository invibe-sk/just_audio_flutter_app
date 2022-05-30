import 'package:flutter/material.dart';
import 'package:knihy_audio_app_new/widgets/auto_size_marquee.dart';

class BookListTitle extends StatelessWidget {
  const BookListTitle({Key? key, required this.name, required this.author}) : super(key: key);

  final String name;
  final String author;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: Theme.of(context).textTheme.headline3?.fontSize,
              child: AutoSizeMarquee(
                text: name,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            const SizedBox(height: 5),
            Text(author),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:image_fade/image_fade.dart';

class BookListImage extends StatelessWidget {
  const BookListImage({Key? key, required this.imageUrl}) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: ImageFade(
            fit: BoxFit.fill,
            image: NetworkImage(imageUrl),
            duration: const Duration(milliseconds: 900),
            syncDuration: const Duration(milliseconds: 250),
            placeholder: Container(
              color: const Color(0xFFCFCDCA),
              alignment: Alignment.center,
              child: const Icon(Icons.photo, color: Colors.white30, size: 20),
            ),
          ),
        ),
      ),
    );
  }
}

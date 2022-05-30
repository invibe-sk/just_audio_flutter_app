
import 'package:flutter/material.dart';
import 'package:image_fade/image_fade.dart';

class AppBarSliver extends StatelessWidget {
  const AppBarSliver({Key? key, required this.imageUrl}) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      stretch: true,
      expandedHeight: 280,
      flexibleSpace: Stack(
        children: <Widget>[
          Positioned.fill(
            child: ImageFade(
              fit: BoxFit.fill,
              image: NetworkImage(imageUrl),
              duration: const Duration(milliseconds: 900),
              syncDuration: const Duration(milliseconds: 250),
              placeholder: Container(),
            ),
          )
        ],
      ),
    );
  }
}
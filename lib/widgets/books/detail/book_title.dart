import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:knihy_audio_app_new/widgets/elevated_container.dart';

class BookTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? duration;

  const BookTitle({
    Key? key,
    required this.title,
    required this.subtitle,
    this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  title,
                  maxLines: 3,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Row(
            children: [
              BookTitleIcon(
                icon: Icons.watch_later_outlined,
                title: duration ?? "",
              ),
            ],
          )
        ],
      ),
    );
  }
}

class BookTitleIcon extends StatelessWidget {
  final IconData icon;
  final String title;

  const BookTitleIcon({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(fontSize: 12, color: Colors.black),
        ),
      ],
    );
  }
}

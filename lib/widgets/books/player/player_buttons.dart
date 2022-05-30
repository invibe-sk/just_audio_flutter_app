import 'package:flutter/material.dart';
import 'package:knihy_audio_app_new/widgets/books/player/buttons/play_pause_button.dart';
import 'package:knihy_audio_app_new/widgets/books/player/buttons/rewind_fifteen_seconds_button.dart';
import 'package:knihy_audio_app_new/widgets/books/player/buttons/rewind_to_previous_chapter_button.dart';
import 'package:knihy_audio_app_new/widgets/books/player/buttons/skip_fifteen_seconds_button.dart';
import 'package:knihy_audio_app_new/widgets/books/player/buttons/skip_to_next_chapter_button.dart';

class PlayerButtons extends StatelessWidget {
  const PlayerButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const RewindFifteenSecondsButton(),
        const RewindToPreviousChapterButton(),
        PlayPauseButton(),
        const SkipToNextChapterButton(),
        const SkipFifteenSecondsButton(),
      ],
    );
  }
}

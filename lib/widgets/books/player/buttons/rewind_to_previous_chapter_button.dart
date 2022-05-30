import 'package:flutter/material.dart';
import 'package:knihy_audio_app_new/services/audio_player_state.dart';
import 'package:knihy_audio_app_new/services/service_locator.dart';

class RewindToPreviousChapterButton extends StatelessWidget {
  const RewindToPreviousChapterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myAudioPlayerState = getIt<MyAudioPlayerState>();

    return ValueListenableBuilder(
      valueListenable: myAudioPlayerState.isFirstChapterNotifier,
      builder: (_, bool isFirstChapter, __) {
        return IconButton(
          onPressed: isFirstChapter ? null : myAudioPlayerState.previous,
          icon: const Icon(Icons.skip_previous),
          color: isFirstChapter ? Colors.grey : Colors.black,
          splashColor: Colors.transparent,
        );
      },
    );
  }
}

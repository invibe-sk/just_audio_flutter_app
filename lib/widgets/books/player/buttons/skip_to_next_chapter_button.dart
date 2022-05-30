import 'package:flutter/material.dart';
import 'package:knihy_audio_app_new/services/audio_player_state.dart';
import 'package:knihy_audio_app_new/services/service_locator.dart';

class SkipToNextChapterButton extends StatelessWidget {
  const SkipToNextChapterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myAudioPlayerState = getIt<MyAudioPlayerState>();

    return ValueListenableBuilder(
      valueListenable: myAudioPlayerState.isLastChapterNotifier,
      builder: (_, bool isLastChapter, __) {
        return IconButton(
          onPressed: isLastChapter ? null : myAudioPlayerState.next,
          icon: const Icon(Icons.skip_next),
          color: isLastChapter ? Colors.grey : Colors.black,
          splashColor: Colors.transparent,
        );
      },
    );
  }
}

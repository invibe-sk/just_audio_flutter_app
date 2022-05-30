import 'package:flutter/material.dart';
import 'package:knihy_audio_app_new/services/audio_player_state.dart';
import 'package:knihy_audio_app_new/services/service_locator.dart';
import 'package:knihy_audio_app_new/widgets/auto_size_marquee.dart';

class PlayerTitle extends StatelessWidget {
  const PlayerTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myAudioPlayerState = getIt<MyAudioPlayerState>();

    return ValueListenableBuilder(
      valueListenable: myAudioPlayerState.currentChapterTitleNotifier,
      builder: (_, String title, __) {
        return SizedBox(
          width: double.infinity,
          height: 18,
          child: AutoSizeMarquee(
            text: title,
            style: const TextStyle(fontSize: 18, height: 1),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}

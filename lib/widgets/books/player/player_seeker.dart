import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:knihy_audio_app_new/services/audio_player_state.dart';
import 'package:knihy_audio_app_new/services/service_locator.dart';
import 'package:knihy_audio_app_new/services/notifiers/progress_notifier.dart';

class PlayerSeeker extends StatelessWidget {
  const PlayerSeeker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myAudioPlayerState = getIt<MyAudioPlayerState>();

    return ValueListenableBuilder(
      valueListenable: myAudioPlayerState.progressNotifier,
      builder: (_,ProgressBarState value, __) {
        return ProgressBar(
          timeLabelPadding: 7,
          progressBarColor: Theme.of(context).primaryColor,
          thumbColor: Theme.of(context).primaryColor,
          thumbGlowColor: Colors.transparent,
          bufferedBarColor: const Color(0xFFB3B3B3),
          baseBarColor: const Color(0xFFD9D9D9),
          progress: value.current,
          thumbRadius: 10,
          buffered: value.buffered,
          total: value.total,
          onSeek: (Duration newPosition) {
            myAudioPlayerState.seek(newPosition);
          },
        );
      },
    );
  }
}

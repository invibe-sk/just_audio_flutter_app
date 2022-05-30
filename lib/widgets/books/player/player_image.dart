import 'package:flutter/material.dart';
import 'package:image_fade/image_fade.dart';
import 'package:knihy_audio_app_new/services/audio_player_state.dart';
import 'package:knihy_audio_app_new/services/service_locator.dart';

class PlayerImage extends StatelessWidget {
  const PlayerImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myAudioPlayerState = getIt<MyAudioPlayerState>();

    return ValueListenableBuilder(
      valueListenable: myAudioPlayerState.currentChapterImageNotifier,
      builder: (_, String title, __) {
        return AspectRatio(
          aspectRatio: 1,
          child: ImageFade(
            alignment: Alignment.center,
            fit: BoxFit.fill,
            image: NetworkImage(title),
            duration: const Duration(milliseconds: 900),
            syncDuration: const Duration(milliseconds: 250),
            placeholder: Container(),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:knihy_audio_app_new/services/audio_player_state.dart';
import 'package:knihy_audio_app_new/services/service_locator.dart';
import 'package:knihy_audio_app_new/widgets/books/player/skip_seconds_button.dart';

class SkipFifteenSecondsButton extends StatelessWidget {
  const SkipFifteenSecondsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final myAudioPlayerState = getIt<MyAudioPlayerState>();

    return SkipSecondsIconButton(
      onPressed: () => myAudioPlayerState.skipFifteenSeconds(),
    );
  }
}

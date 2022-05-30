import 'package:flutter/material.dart';
import 'package:knihy_audio_app_new/services/audio_player_state.dart';
import 'package:knihy_audio_app_new/services/notifiers/play_button_notifier.dart';
import 'package:knihy_audio_app_new/services/service_locator.dart';

class PlayPauseButton extends StatelessWidget {
  PlayPauseButton({Key? key}) : super(key: key);

  final audioPlayerState = getIt<MyAudioPlayerState>();

  Widget _buildPlayButton(ButtonState buttonState, BuildContext context) {
    if (buttonState == ButtonState.loading) {
      return Container(
        margin: const EdgeInsets.all(8.0),
        width: 36,
        height: 36,
        child: const CircularProgressIndicator(
          color: Colors.black,
        ),
      );
    } else {
      return IconButton(
        icon: Icon(buttonState == ButtonState.playing ? Icons.pause : Icons.play_arrow),
        iconSize: 36,
        splashColor: Colors.transparent,
        onPressed: () {
          if (buttonState == ButtonState.playing) {
            audioPlayerState.pause();
          } else {
            audioPlayerState.play();
          }
        },
      );
    }
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Consumer<AudioPlayerState>(
  //       builder: (context, audioPlayerState, child) {
  //         return _buildPlayButton(audioPlayerState.buttonState, context);
  //       }
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: audioPlayerState.playButtonNotifier,
      builder: (_, ButtonState value, __) {
        return _buildPlayButton(value, context);
      },
    );
  }
}

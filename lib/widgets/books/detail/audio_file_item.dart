import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:knihy_audio_app_new/models/audiofile.dart';
import 'package:marquee/marquee.dart';

class AudioFileItem extends StatelessWidget {
  final AudioFile audioFile;

  const AudioFileItem({Key? key, required this.audioFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.black26))),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.play_arrow),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: SizedBox(
              height: 14,
              child: _title(text: audioFile.name),
            ),
          ),
        ],
      ),
    );
  }

  Widget _title({required String text}) {
    return AutoSizeText(
      text,
      maxLines: 1,
      minFontSize: 14,
      maxFontSize: 14,
      style: const TextStyle(fontSize: 14, height: 1),
      overflowReplacement: Marquee(
        blankSpace: 20.0,
        pauseAfterRound: const Duration(seconds: 3),
        text: text,
      ),
    );
  }
}

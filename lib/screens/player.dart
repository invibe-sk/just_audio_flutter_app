import 'package:flutter/material.dart';
import 'package:knihy_audio_app_new/models/book.dart';
import 'package:knihy_audio_app_new/services/audio_player_state.dart';
import 'package:knihy_audio_app_new/services/service_locator.dart';
import 'package:knihy_audio_app_new/widgets/books/player/player_buttons.dart';
import 'package:knihy_audio_app_new/widgets/books/player/player_image.dart';
import 'package:knihy_audio_app_new/widgets/books/player/player_seeker.dart';
import 'package:knihy_audio_app_new/widgets/books/player/player_title.dart';

class PlayerScreen extends StatefulWidget {
  static const routeName = '/player';

  const PlayerScreen({Key? key}) : super(key: key);

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {

  final myAudioPlayerState = getIt<MyAudioPlayerState>();

  @override
  initState() {
    myAudioPlayerState.play();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PlayerScreenArguments args =
        ModalRoute.of(context)?.settings.arguments as PlayerScreenArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.book.name),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints.expand(width: 800),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                PlayerImage(),
                SizedBox(height: 20),
                PlayerTitle(),
                SizedBox(height: 20),
                PlayerSeeker(),
                PlayerButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PlayerScreenArguments {
  final Book book;

  PlayerScreenArguments({required this.book});
}

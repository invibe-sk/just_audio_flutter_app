import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:knihy_audio_app_new/models/book.dart';
import 'package:knihy_audio_app_new/screens/player.dart';
import 'package:knihy_audio_app_new/services/audio_player_state.dart';
import 'package:knihy_audio_app_new/services/service_locator.dart';
import 'package:knihy_audio_app_new/widgets/books/detail/app_bar_sliver.dart';
import 'package:knihy_audio_app_new/widgets/books/detail/audio_file_item.dart';
import 'package:knihy_audio_app_new/widgets/books/detail/book_entities.dart';
import 'package:knihy_audio_app_new/widgets/books/detail/book_title.dart';
import 'package:knihy_audio_app_new/widgets/elevated_container.dart';

class BookScreen extends StatefulWidget {
  static const String routeName = '/book';

  const BookScreen({Key? key}) : super(key: key);

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {

  final myAudioPlayerState = getIt<MyAudioPlayerState>();

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as BookScreenArguments;

    Book book = arguments.book;

    return Scaffold(
      floatingActionButton: buildFloatingActionButton(context, book),
      body: CustomScrollView(
        slivers: [
          AppBarSliver(imageUrl: book.imageUrl),
          SliverToBoxAdapter(
            child: Column(
              children: [
                BookTitle(title: book.name, subtitle: book.author, duration: book.duration),
                _buildBookEntities(title: "Kategórie", entities: book.categories),
                _buildBookEntities(title: "Interpreti", entities: book.performers),
                _buildBookEntities(title: "Vydavatelia", entities: book.publishers),
                _buildFiles(book),
              ],
            ),
          )
        ],
      ),
    );
  }

  void rebuildPlaylistAndPlay(Book book) async {
    await myAudioPlayerState.clearPlaylist();
    await myAudioPlayerState.loadPlaylist(book);

    if (!mounted) return;
    Navigator.of(context).pushNamed(
      PlayerScreen.routeName,
      arguments: PlayerScreenArguments(book: book),
    );
  }

  FloatingActionButton buildFloatingActionButton(BuildContext context, Book book) {
    if (!book.bought) {
      return FloatingActionButton.extended(
        onPressed: () async {
          if (!mounted) return;
          Navigator.of(context).pushNamed(
            PlayerScreen.routeName,
            arguments: PlayerScreenArguments(book: book),
          );
        },
        label: const Text("Ukážka"),
        icon: const Icon(Icons.play_arrow),
      );
    } else {
      Box<dynamic> box = Hive.box('books');

      if (box.containsKey(book.id)) {
        return FloatingActionButton.extended(
          onPressed: () async => rebuildPlaylistAndPlay(book),
          label: const Text("Pokračovať"),
          icon: const Icon(Icons.play_arrow),
        );
      } else {
        return FloatingActionButton(
          onPressed: () async => rebuildPlaylistAndPlay(book),
          child: const Icon(Icons.play_arrow),
        );
      }

    }
  }

  List<Widget> _buildList(List list) {
    return List<Widget>.generate(list.length, (int index) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black12,
        ),
        child: Text(list[index]),
      );
    });
  }

  Widget _buildBookEntities({required String title, required List entities}) {
    if (entities.isNotEmpty) {
      return BookEntities(
        title: title,
        children: _buildList(entities),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _buildFiles(Book book) {
    if (book.files.isNotEmpty && book.bought) {
      return ElevatedContainer(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Kapitoly", style: TextStyle(fontSize: 16)),
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: book.files.length,
              shrinkWrap: true,
              itemBuilder: (_, index) => GestureDetector(
                child: AudioFileItem(
                  audioFile: book.files[index],
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}



class BookScreenArguments {
  final Book book;

  BookScreenArguments({required this.book});
}

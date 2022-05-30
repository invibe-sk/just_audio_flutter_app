import 'package:flutter/foundation.dart';
import 'package:audio_service/audio_service.dart';
import 'package:knihy_audio_app_new/models/audiofile.dart';
import 'package:knihy_audio_app_new/models/book.dart';
import 'package:knihy_audio_app_new/services/audio_handler.dart';
import 'package:knihy_audio_app_new/services/notifiers/play_button_notifier.dart';
import 'package:knihy_audio_app_new/services/notifiers/progress_notifier.dart';
import 'package:knihy_audio_app_new/services/service_locator.dart';

class MyAudioPlayerState {
  final _audioHandler = getIt<AudioHandler>() as MyAudioHandler;

  final currentSongNotifier = ValueNotifier<String>('');
  final playlistNotifier = ValueNotifier<List<String>>([]);
  final progressNotifier = ProgressNotifier();
  final isFirstChapterNotifier = ValueNotifier<bool>(true);
  final playButtonNotifier = PlayButtonNotifier();
  final isLastChapterNotifier = ValueNotifier<bool>(true);
  final currentChapterTitleNotifier = ValueNotifier<String>('');
  final currentChapterImageNotifier = ValueNotifier<String>('');

  void init() {
    _listenToPlaybackState();
    _listenToCurrentPosition();
    _listenToBufferedPosition();
    _listenToTotalDuration();
    _listenToChangesInSong();
    _listenToChangesInPlaylist();
  }

  Future<void> loadPlaylist(Book book) async => await _loadPlaylist(book);

  Future<void> play() async => await _audioHandler.play();

  Future<void> pause() async => await _audioHandler.pause();

  Future<void> seek(Duration position) async => await _audioHandler.seek(position);

  Future<void> previous() async => await _audioHandler.skipToPrevious();

  Future<void> next() async => await _audioHandler.skipToNext();

  void add() {}

  Future<void> removeLastItemFromIndex() async {
    final lastIndex = _audioHandler.queue.value.length - 1;
    if (lastIndex < 0) return;
    await _audioHandler.removeQueueItemAt(lastIndex);
  }

  Future<void> clearPlaylist() async {
    final lastIndex = _audioHandler.queue.value.length - 1;

    for (int i = 0; i <= lastIndex; i++) {
      await removeLastItemFromIndex();
    }
  }

  void dispose() => _audioHandler.dispose();

  Future<void> stop() => _audioHandler.stop();

  void skipFifteenSeconds() => _audioHandler.skipFifteenSeconds();

  void rewindFifteenSeconds() => _audioHandler.rewindFifteenSeconds();

  Future<void> _loadPlaylist(Book book) async {
    List<MediaItem> mediaItems =
    book.bought ? _buildPlaylist(book) : _buildPreviewPlaylist(book);

    await _audioHandler.addQueueItems(mediaItems);
  }

  _buildPreviewPlaylist(Book book) {
    return [
      MediaItem(
        id: book.id.toString(),
        album: book.name,
        title: "Ukážka: ${book.name}",
        artUri: Uri.parse(book.imageUrl),
        extras: {'url': book.preview},
      ),
    ];
  }

  _buildPlaylist(Book book) {
    return book.files.map((AudioFile audioFile) {
      return MediaItem(
        id: audioFile.id.toString(),
        album: book.name,
        title: audioFile.name,
        artUri: Uri.parse(book.imageUrl),
        extras: {'url': audioFile.url, 'book_id': book.id},
      );
    }).toList();
  }

  bool _loadingOrBuffering(AudioProcessingState state) {
    return state == AudioProcessingState.loading || state == AudioProcessingState.buffering;
  }

  void _listenToPlaybackState() {
    _audioHandler.playbackState.listen((playbackState) {
      final isPlaying = playbackState.playing;
      final processingState = playbackState.processingState;

      if (_loadingOrBuffering(processingState)) {
        playButtonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        playButtonNotifier.value = ButtonState.paused;
      } else if (processingState != AudioProcessingState.completed) {
        playButtonNotifier.value = ButtonState.playing;
      } else {
        _audioHandler.seek(Duration.zero);
        _audioHandler.pause();
      }
    });
  }

  void _listenToCurrentPosition() {
    AudioService.position.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });
  }

  void _listenToBufferedPosition() {
    _audioHandler.playbackState.listen((playbackState) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: playbackState.bufferedPosition,
        total: oldState.total,
      );
    });
  }

  void _listenToTotalDuration() {
    _audioHandler.mediaItem.listen((mediaItem) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: mediaItem?.duration ?? Duration.zero,
      );
    });
  }

  void _listenToChangesInSong() {
    _audioHandler.mediaItem.listen((mediaItem) {
      currentChapterTitleNotifier.value = mediaItem?.title ?? '';
      currentChapterImageNotifier.value = mediaItem?.artUri.toString() ?? '';
      _updateSkipButtons();
    });
  }

  void _updateSkipButtons() {
    final mediaItem = _audioHandler.mediaItem.value;
    final playlist = _audioHandler.queue.value;

    if (playlist.length < 2 || mediaItem == null) {
      isFirstChapterNotifier.value = true;
      isLastChapterNotifier.value = true;
    } else {
      isFirstChapterNotifier.value = playlist.first == mediaItem;
      isLastChapterNotifier.value = playlist.last == mediaItem;
    }
  }

  void _listenToChangesInPlaylist() {
    _audioHandler.queue.listen((playlist) {
      if (playlist.isEmpty) {
        currentChapterTitleNotifier.value = '';
        currentChapterImageNotifier.value = '';
      }

      _updateSkipButtons();
    });
  }
}

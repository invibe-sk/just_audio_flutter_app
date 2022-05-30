import 'package:knihy_audio_app_new/models/audiofile.dart';

class Book {
  int id;
  String name;
  String imageUrl;
  String author;
  String? duration;
  bool bought = false;
  String? preview;
  int? previewDuration;
  List<dynamic> authors = [];
  List<dynamic> categories = [];
  List<dynamic> genres = [];
  List<dynamic> performers = [];
  List<dynamic> publishers = [];
  List<AudioFile> files = [];

  Book({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.author,
  });

  Book.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        imageUrl = json['image'],
        duration = json['duration'],
        bought = json['bought'],
        previewDuration = json['preview_duration'],
        preview = json['preview'],
        author = json['author'] ?? "Neznámy autor",
        authors = json['authors'] ?? [],
        categories = json['categories'] ?? [],
        genres = json['genres'] ?? [],
        performers = json['performers'] ?? [],
        publishers = json['publishers'] ?? [],
        files = List<AudioFile>.generate(
          json['files'].length,
          (index) {
            return AudioFile(
              name: json['files'][index]['name'],
              id: json['files'][index]['id'],
              url: json['files'][index]['signed_url'],
              duration: json['files'][index]['duration'],
            );
          },
        );
}

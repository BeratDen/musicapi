import 'package:music_app_gui/models/music.dart';

class Album {
  final String name;
  final String value;
  final String artist;
  final String image;
  final DateTime releaseDate;
  final int stars;
  final List<Music> musics;

  const Album({
    required this.name,
    required this.value,
    required this.artist,
    required this.image,
    required this.releaseDate,
    required this.stars,
    required this.musics,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    try {
      final List<dynamic>? musicsJson = json['musics'];

      if (musicsJson == null || musicsJson.isEmpty) {
        return Album(
          name: json['name'],
          artist: json['artist'],
          value: json['value'],
          image: json['image'],
          releaseDate: DateTime.parse(json['release_date']),
          stars: json['num_stars'] != null
              ? int.parse(json['num_stars'].toString())
              : 0,
          musics: [],
        );
      }

      final List<Music> musics =
          musicsJson.map((e) => Music.fromJson(e)).toList();

      return Album(
        name: json['name'],
        artist: json['artist'],
        value: json['value'],
        image: json['image'],
        releaseDate: DateTime.parse(json['release_date']),
        stars: json['num_stars'] != null
            ? int.parse(json['num_stars'].toString())
            : 0,
        musics: musics,
      );
    } catch (e) {
      throw FormatException('Failed to fetch album. Error: $e');
    }
  }
}

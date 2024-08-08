// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:collection/collection.dart';

class Music {
  final String name;
  final String value;
  final String? lyrics;
  final String artist;
  final String artistName;
  final String? musicUrl;
  final String? imageUrl;
  final String? videoUrl;
  final DateTime releaseDate;
  final int stars;
  final List<dynamic> categories;
  final List<dynamic> albums;
  final bool isFromYouTube;
  Music({
    required this.name,
    required this.value,
    this.lyrics,
    required this.artist,
    required this.artistName,
    this.musicUrl,
    this.imageUrl,
    this.videoUrl,
    required this.releaseDate,
    required this.stars,
    required this.categories,
    required this.albums,
    required this.isFromYouTube,
  });

  Music copyWith({
    String? name,
    String? value,
    String? lyrics,
    String? artist,
    String? artistName,
    String? musicUrl,
    String? imageUrl,
    String? videoUrl,
    DateTime? releaseDate,
    int? stars,
    List<dynamic>? categories,
    List<dynamic>? albums,
    bool? isFromYouTube,
  }) {
    return Music(
      name: name ?? this.name,
      value: value ?? this.value,
      lyrics: lyrics ?? this.lyrics,
      artist: artist ?? this.artist,
      artistName: artistName ?? this.artistName,
      musicUrl: musicUrl ?? this.musicUrl,
      imageUrl: imageUrl ?? this.imageUrl,
      videoUrl: videoUrl ?? this.videoUrl,
      releaseDate: releaseDate ?? this.releaseDate,
      stars: stars ?? this.stars,
      categories: categories ?? this.categories,
      albums: albums ?? this.albums,
      isFromYouTube: isFromYouTube ?? this.isFromYouTube,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'value': value,
      'lyrics': lyrics,
      'artist': artist,
      'artistName': artistName,
      'musicUrl': musicUrl,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'releaseDate': releaseDate.millisecondsSinceEpoch,
      'stars': stars,
      'categories': categories,
      'albums': albums,
      'isFromYouTube': isFromYouTube,
    };
  }

  factory Music.fromMap(Map<String, dynamic> map) {
    return Music(
      name: map['name'] as String,
      value: map['value'] as String,
      lyrics: map['lyrics'] != null ? map['lyrics'] as String : null,
      artist: map['artist'] as String,
      artistName: map['artist_name'] as String,
      musicUrl: map['music_url'] != null ? map['music_url'] as String : null,
      imageUrl: map['image_url'] != null ? map['image_url'] as String : null,
      videoUrl: map['video_url'] != null ? map['video_url'] as String : null,
      releaseDate: DateTime.parse(map['release_date'] ?? ''),
      stars: map['num_stars'] as int,
      categories: List<dynamic>.from((map['category'] as List<dynamic>)),
      albums: List<dynamic>.from((map['albums'] as List<dynamic>)),
      isFromYouTube: map['is_from_youtube'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Music.fromJson(Map<String, dynamic> json) {
    try {
      final dynamic categoriesJson = json['category'];
      final dynamic albumsJson = json['albums'];
      List<String> localCategories;
      List<String> localAlbums;
      if (categoriesJson == null || categoriesJson.isEmpty) {
        return Music(
          name: json['name'],
          value: json['value'],
          lyrics: json['lyrics'],
          artist: json['artist'],
          artistName: json['artist_name'],
          musicUrl: json['music_url'],
          imageUrl: json['image_url'],
          videoUrl: json['video_url'],
          releaseDate: DateTime.parse(json['release_date']),
          stars: int.parse(json['num_stars'].toString()),
          albums: [],
          categories: [],
          isFromYouTube: json['is_from_youtube'],
        );
      }

      if (categoriesJson is List && albumsJson is List) {
        // "category" is a list of strings
        localCategories = List<String>.from(
            categoriesJson.map((category) => category.toString()));
        localAlbums = List<String>.from(albumsJson.map((e) => e.toString()));
      } else {
        // "category" is a single item (string or null)
        localCategories = [categoriesJson?.toString() ?? ''];
        localAlbums = [albumsJson?.toString() ?? ''];
      }

      return Music(
          name: json['name'],
          value: json['value'],
          lyrics: json['lyrics'],
          artist: json['artist'],
          artistName: json['artist_name'],
          musicUrl: json['music_url'] ?? '',
          imageUrl: json['image_url'] ?? '',
          videoUrl: json['video_url'] ?? '',
          releaseDate: DateTime.parse(json['release_date']),
          stars: int.parse(json['num_stars'].toString()),
          categories: localCategories,
          albums: localAlbums,
          isFromYouTube: json['is_from_youtube'] ?? false);
    } catch (e) {
      throw FormatException('Failed to fetch music. Error: $e');
    }
  }

  static Future<List<Music>> fromYouTubeJson(Map<String, dynamic> json) async {
    try {
      final List<dynamic> items = json['items'];
      if (items.isEmpty) {
        throw const FormatException('No items found in the YouTube response.');
      }

      List<Music> musicList = await Future.wait(items.map((item) async {
        final snippet = item['snippet'];
        final videoId = item['id']['videoId'];

        return Music(
          name: snippet['title'],
          value: 'default',
          lyrics: null,
          artist: snippet['channelTitle'],
          artistName: snippet['channelTitle'],
          musicUrl: videoId,
          imageUrl: snippet['thumbnails']['high']['url'],
          videoUrl: videoId,
          releaseDate: DateTime.parse(snippet['publishTime']),
          isFromYouTube: true,
          stars: 0,
          categories: [],
          albums: [],
        );
      }).toList());
      return musicList;
    } catch (e) {
      throw FormatException(
          'Failed to fetch music from YouTube response. Error: $e');
    }
  }

  // static Future<String> _getDirectVideoUrl(
  //     YoutubeExplode yt, String videoId) async {
  //   try {
  //     var manifest = await yt.videos.streamsClient.getManifest(videoId);
  //     var streamInfo = manifest.muxed.bestQuality;
  //     return streamInfo.url.toString();
  //   } catch (e) {
  //     debugPrint('Error fetching direct video URL: $e');
  //   }
  //   return "";
  // }

  @override
  String toString() {
    return 'Music(name: $name, value: $value, lyrics: $lyrics, artist: $artist, artistName: $artistName, musicUrl: $musicUrl, imageUrl: $imageUrl, videoUrl: $videoUrl, releaseDate: $releaseDate, stars: $stars, categories: $categories, albums: $albums, isFromYouTube: $isFromYouTube)';
  }

  @override
  bool operator ==(covariant Music other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.name == name &&
        other.value == value &&
        other.lyrics == lyrics &&
        other.artist == artist &&
        other.artistName == artistName &&
        other.musicUrl == musicUrl &&
        other.imageUrl == imageUrl &&
        other.videoUrl == videoUrl &&
        other.releaseDate == releaseDate &&
        other.stars == stars &&
        listEquals(other.categories, categories) &&
        listEquals(other.albums, albums) &&
        other.isFromYouTube == isFromYouTube;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        value.hashCode ^
        lyrics.hashCode ^
        artist.hashCode ^
        artistName.hashCode ^
        musicUrl.hashCode ^
        imageUrl.hashCode ^
        videoUrl.hashCode ^
        releaseDate.hashCode ^
        stars.hashCode ^
        categories.hashCode ^
        albums.hashCode ^
        isFromYouTube.hashCode;
  }
}

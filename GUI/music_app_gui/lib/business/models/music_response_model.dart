// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

class MusicResponseModel {
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
  final List<String> categories;
  final List<String> albums;
  final bool isFromYouTube;

  MusicResponseModel({
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

  MusicResponseModel copyWith({
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
    List<String>? categories,
    List<String>? albums,
    bool? isFromYouTube,
  }) {
    return MusicResponseModel(
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

  factory MusicResponseModel.fromMap(Map<String, dynamic> map) {
    return MusicResponseModel(
      name: map['name'] as String,
      value: map['value'] as String,
      lyrics: map['lyrics'] != null ? map['lyrics'] as String : null,
      artist: map['artist'] as String,
      artistName: map['artist_name'] as String,
      musicUrl: map['music_url'] != null ? map['music_url'] as String : null,
      imageUrl: map['image_url'] != null ? map['image_url'] as String : null,
      videoUrl: map['video_url'] != null ? map['video_url'] as String : null,
      releaseDate: DateTime.parse(map['release_date']),
      stars: map['num_stars'] as int,
      categories: List<String>.from((map['category'] ?? [] as List<String>)),
      albums: List<String>.from((map['albums'] ?? [] as List<String>)),
      isFromYouTube: map['isFromYouTube'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory MusicResponseModel.fromJson(String source) =>
      MusicResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MusicResponseModel(name: $name, value: $value, lyrics: $lyrics, artist: $artist, artistName: $artistName, musicUrl: $musicUrl, imageUrl: $imageUrl, videoUrl: $videoUrl, releaseDate: $releaseDate, stars: $stars, categories: $categories, albums: $albums, isFromYouTube: $isFromYouTube)';
  }

  @override
  bool operator ==(covariant MusicResponseModel other) {
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

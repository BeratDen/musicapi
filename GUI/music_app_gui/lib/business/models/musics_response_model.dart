// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:music_app_gui/models/music.dart';

/// The `MusicsResponseModel` class represents a model for a list of music objects with methods for serialization and
/// deserialization.
class MusicsResponseModel {
  List<Music> musics;
  MusicsResponseModel({
    required this.musics,
  });

  MusicsResponseModel copyWith({
    List<Music>? musics,
  }) {
    return MusicsResponseModel(
      musics: musics ?? this.musics,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'musics': musics.map((x) => x.toMap()).toList(),
    };
  }

  factory MusicsResponseModel.fromMap(Map<String, dynamic> map) {
    return MusicsResponseModel(
      musics: List<Music>.from(
        (map['musics'] as List<int>).map<Music>(
          (x) => Music.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory MusicsResponseModel.fromList(List<dynamic> list) {
    return MusicsResponseModel(
        musics: list
            .map((e) => Music(
                name: e.name,
                value: e.value,
                lyrics: e.lyrics,
                artist: e.artist,
                artistName: e.artistName,
                musicUrl: e.musicUrl,
                imageUrl: e.imageUrl,
                videoUrl: e.videoUrl,
                releaseDate: e.releaseDate,
                stars: e.stars,
                categories: e.categories,
                albums: e.albums,
                isFromYouTube: e.isFromYouTube))
            .toList());
  }

  String toJson() => json.encode(toMap());

  factory MusicsResponseModel.fromJson(String source) =>
      MusicsResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MusicsResponseModel(musics: $musics)';

  @override
  bool operator ==(covariant MusicsResponseModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return listEquals(other.musics, musics);
  }

  @override
  int get hashCode => musics.hashCode;
}

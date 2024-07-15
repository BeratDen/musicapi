// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:music_app_gui/models/list.dart';

class MusicsListResponseModel {
  List<MusicList> musicLists;
  MusicsListResponseModel({
    required this.musicLists,
  });

  MusicsListResponseModel copyWith({
    List<MusicList>? musicLists,
  }) {
    return MusicsListResponseModel(
      musicLists: musicLists ?? this.musicLists,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'musics': musicLists.map((x) => x.toMap()).toList(),
    };
  }

  factory MusicsListResponseModel.fromMap(Map<String, dynamic> map) {
    return MusicsListResponseModel(
      musicLists: List<MusicList>.from(
        (map['musics'] as List<int>).map<MusicList>(
          (x) => MusicList.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory MusicsListResponseModel.fromList(List<dynamic> list) {
    return MusicsListResponseModel(
        musicLists: list.map((e) => MusicList.fromMap(e)).toList());
  }

  String toJson() => json.encode(toMap());

  factory MusicsListResponseModel.fromJson(String source) =>
      MusicsListResponseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MusicsListResponseModel(musics: $musicLists)';

  @override
  bool operator ==(covariant MusicsListResponseModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return listEquals(other.musicLists, musicLists);
  }

  @override
  int get hashCode => musicLists.hashCode;
}

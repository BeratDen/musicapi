// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:music_app_gui/models/list.dart';

class MusicListsResponseModel {
  List<MusicList> musicLists;
  MusicListsResponseModel({
    required this.musicLists,
  });

  MusicListsResponseModel copyWith({
    List<MusicList>? musicLists,
  }) {
    return MusicListsResponseModel(
      musicLists: musicLists ?? this.musicLists,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'musics': musicLists.map((x) => x.toMap()).toList(),
    };
  }

  factory MusicListsResponseModel.fromMap(Map<String, dynamic> map) {
    return MusicListsResponseModel(
      musicLists: List<MusicList>.from(
        (map['musics'] as List<int>).map<MusicList>(
          (x) => MusicList.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory MusicListsResponseModel.fromList(List<dynamic> list) {
    return MusicListsResponseModel(
        musicLists: list.map((e) => MusicList.fromMap(e)).toList());
  }

  String toJson() => json.encode(toMap());

  factory MusicListsResponseModel.fromJson(String source) =>
      MusicListsResponseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MusicListsResponseModel(musics: $musicLists)';

  @override
  bool operator ==(covariant MusicListsResponseModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return listEquals(other.musicLists, musicLists);
  }

  @override
  int get hashCode => musicLists.hashCode;
}

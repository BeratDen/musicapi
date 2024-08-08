// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:music_app_gui/models/album.dart';

class AlbumListResponseModel {
  List<Album> albums;
  AlbumListResponseModel({
    required this.albums,
  });

  AlbumListResponseModel copyWith({
    List<Album>? albums,
  }) {
    return AlbumListResponseModel(
      albums: albums ?? this.albums,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'albums': albums.map((x) => x.toMap()).toList(),
    };
  }

  factory AlbumListResponseModel.fromMap(Map<String, dynamic> map) {
    return AlbumListResponseModel(
      albums: List<Album>.from(
        (map['albums'] as List<int>).map<Album>(
          (x) => Album.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory AlbumListResponseModel.fromJson(String source) =>
      AlbumListResponseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  factory AlbumListResponseModel.fromList(List<dynamic> list) {
    return AlbumListResponseModel(
        albums: list.map((e) => Album.fromJson(e)).toList());
  }

  @override
  String toString() => 'AlbumListResponseModel(albums: $albums)';

  @override
  bool operator ==(covariant AlbumListResponseModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return listEquals(other.albums, albums);
  }

  @override
  int get hashCode => albums.hashCode;
}

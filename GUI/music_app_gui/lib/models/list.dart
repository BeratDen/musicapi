// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

class MusicList {
  final int id;
  final String name;
  final String description;
  final String slug;
  final String image;
  final String creator;
  final List musics;

  const MusicList(
      {required this.id,
      required this.name,
      required this.description,
      required this.slug,
      required this.image,
      required this.creator,
      required this.musics});

  factory MusicList.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
        'description': String description,
        'slug': String slug,
        'image': String image,
        'creator': String creator,
        'musics': List musics
      } =>
        MusicList(
          id: id,
          name: name,
          description: description,
          slug: slug,
          image: image,
          creator: creator,
          musics: musics,
        ),
      _ => throw const FormatException('Failed to fetch list')
    };
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'slug': slug,
      'image': image,
      'creator': creator,
      'musics': musics,
    };
  }

  MusicList copyWith({
    int? id,
    String? name,
    String? description,
    String? slug,
    String? image,
    String? creator,
    List? musics,
  }) {
    return MusicList(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      slug: slug ?? this.slug,
      image: image ?? this.image,
      creator: creator ?? this.creator,
      musics: musics ?? this.musics,
    );
  }

  factory MusicList.fromMap(Map<String, dynamic> map) {
    return MusicList(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      slug: map['slug'] as String,
      image: map['image'] as String,
      creator: map['creator'] as String,
      musics: List.from((map['musics'] as List)),
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'MusicList(id: $id, name: $name, description: $description, slug: $slug, image: $image, creator: $creator, musics: $musics)';
  }

  @override
  bool operator ==(covariant MusicList other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.slug == slug &&
        other.image == image &&
        other.creator == creator &&
        listEquals(other.musics, musics);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        slug.hashCode ^
        image.hashCode ^
        creator.hashCode ^
        musics.hashCode;
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

class Artist {
  final String? firstName;
  final String? lastName;
  final String? value;
  final String? resume;
  final String? avatar;
  final List<String>? categories;
  final List<String>? albums;
  final List<String>? musics;
  final List<String>? feats;

  const Artist({
    this.firstName,
    this.lastName,
    this.value,
    this.resume,
    this.avatar,
    this.categories,
    this.albums,
    this.musics,
    this.feats,
  });

  Artist copyWith({
    String? firstName,
    String? lastName,
    String? value,
    String? resume,
    String? avatar,
    List<String>? categories,
    List<String>? albums,
    List<String>? musics,
    List<String>? feats,
  }) {
    return Artist(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      value: value ?? this.value,
      resume: resume ?? this.resume,
      avatar: avatar ?? this.avatar,
      categories: categories ?? this.categories,
      albums: albums ?? this.albums,
      musics: musics ?? this.musics,
      feats: feats ?? this.feats,
    );
  }

  factory Artist.fromJson(Map<String, dynamic> json) {
    try {
      final List<dynamic> categoriesJson = json['category'];
      final List<dynamic> albumsJson = json['albums'];
      final List<dynamic> musicsJson = json['musics'];
      final List<dynamic> featsJson = json['feats'];
      // Eğer "category" dizisi yoksa veya boşsa, boş bir liste döndür
      if (categoriesJson.isEmpty &&
          albumsJson.isEmpty &&
          musicsJson.isEmpty &&
          featsJson.isEmpty) {
        return Artist(
          firstName: json['first_name'],
          lastName: json['last_name'],
          value: json['value'],
          resume: json['resume'],
          avatar: json['avatar'],
          categories: [],
          albums: [],
          musics: [],
          feats: [],
        );
      }

      // "category" dizisini String listesine dönüştür
      final List<String> localCategories = categoriesJson.map((category) {
        return category.toString();
      }).toList();
      final List<String> localAlbums = albumsJson.map((album) {
        return album.toString();
      }).toList();
      final List<String> localMusics = musicsJson.map((music) {
        return music.toString();
      }).toList();

      final List<String> localFeats = featsJson.map((feat) {
        return feat.toString();
      }).toList();

      return Artist(
        firstName: json['first_name'],
        lastName: json['last_name'],
        value: json['value'],
        resume: json['resume'],
        avatar: json['avatar'],
        categories: localCategories,
        albums: localAlbums,
        musics: localMusics,
        feats: localFeats,
      );
    } catch (e) {
      throw FormatException('Failed to fetch artist. Error: $e');
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'first_name': firstName,
      'last_name': lastName,
      'value': value,
      'resume': resume,
      'avatar': avatar,
      'category': categories,
      'albums': albums,
      'musics': musics,
      'feats': feats,
    };
  }

  factory Artist.fromMap(Map<String, dynamic> map) {
    return Artist(
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      value: map['value'] != null ? map['value'] as String : null,
      resume: map['resume'] != null ? map['resume'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      categories: map['categories'] != null
          ? List<String>.from((map['categories'] as List<String>))
          : null,
      albums: map['albums'] != null
          ? List<String>.from((map['albums'] as List<dynamic>))
          : null,
      musics: map['musics'] != null
          ? List<String>.from((map['musics'] as List<dynamic>))
          : null,
      feats: map['feats'] != null
          ? List<String>.from((map['feats'] as List<dynamic>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Artist(firstName: $firstName, lastName: $lastName, value: $value, resume: $resume, avatar: $avatar, categories: $categories, albums: $albums, musics: $musics, feats: $feats)';
  }

  @override
  bool operator ==(covariant Artist other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.firstName == firstName &&
        other.lastName == lastName &&
        other.value == value &&
        other.resume == resume &&
        other.avatar == avatar &&
        listEquals(other.categories, categories) &&
        listEquals(other.albums, albums) &&
        listEquals(other.musics, musics) &&
        listEquals(other.feats, feats);
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        value.hashCode ^
        resume.hashCode ^
        avatar.hashCode ^
        categories.hashCode ^
        albums.hashCode ^
        musics.hashCode ^
        feats.hashCode;
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

class SingerResponseModel {
  final String? firstName;
  final String? lastName;
  final String? value;
  final String? resume;
  final String? avatar;
  final List<dynamic>? categories;
  final List<dynamic>? albums;
  final List<dynamic>? musics;
  final List<dynamic>? feats;
  SingerResponseModel({
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

  SingerResponseModel copyWith({
    String? firstName,
    String? lastName,
    String? value,
    String? resume,
    String? avatar,
    List<dynamic>? categories,
    List<dynamic>? albums,
    List<dynamic>? musics,
    List<dynamic>? feats,
  }) {
    return SingerResponseModel(
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'value': value,
      'resume': resume,
      'avatar': avatar,
      'categories': categories,
      'albums': albums,
      'musics': musics,
      'feats': feats,
    };
  }

  factory SingerResponseModel.fromMap(Map<String, dynamic> map) {
    return SingerResponseModel(
      firstName: map['first_name'] != null ? map['first_name'] as String : null,
      lastName: map['last_name'] != null ? map['last_name'] as String : null,
      value: map['value'] != null ? map['value'] as String : null,
      resume: map['resume'] != null ? map['resume'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      categories: map['category'] != null
          ? List<dynamic>.from((map['category'] as List<dynamic>))
          : null,
      albums: map['albums'] != null
          ? List<dynamic>.from((map['albums'] as List<dynamic>))
          : null,
      musics: map['musics'] != null
          ? List<dynamic>.from((map['musics'] as List<dynamic>))
          : null,
      feats: map['feats'] != null
          ? List<dynamic>.from((map['feats'] as List<dynamic>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SingerResponseModel.fromJson(String source) =>
      SingerResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SingerResponseModel(firstName: $firstName, lastName: $lastName, value: $value, resume: $resume, avatar: $avatar, categories: $categories, albums: $albums, musics: $musics, feats: $feats)';
  }

  @override
  bool operator ==(covariant SingerResponseModel other) {
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

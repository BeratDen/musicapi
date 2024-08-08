// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:music_app_gui/models/artis.dart';

class SingersResponseModel {
  List<Artist> singers;
  SingersResponseModel({
    required this.singers,
  });

  SingersResponseModel copyWith({
    List<Artist>? singers,
  }) {
    return SingersResponseModel(
      singers: singers ?? this.singers,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'singers': singers.map((x) => x.toMap()).toList(),
    };
  }

  factory SingersResponseModel.fromMap(Map<String, dynamic> map) {
    return SingersResponseModel(
      singers: List<Artist>.from(
        (map['singers'] as List<int>).map<Artist>(
          (x) => Artist.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory SingersResponseModel.fromList(List<dynamic> list) {
    return SingersResponseModel(
        singers: list.map((e) => Artist.fromMap(e)).toList());
  }

  String toJson() => json.encode(toMap());

  factory SingersResponseModel.fromJson(String source) =>
      SingersResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SingersResponseModel(singers: $singers)';

  @override
  bool operator ==(covariant SingersResponseModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return listEquals(other.singers, singers);
  }

  @override
  int get hashCode => singers.hashCode;
}

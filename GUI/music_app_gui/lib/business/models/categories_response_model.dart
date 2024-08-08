// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:collection/collection.dart';

import '../../models/category.dart';

class CategoriesResponseModel {
  List<Category> categories;
  CategoriesResponseModel({
    required this.categories,
  });

  CategoriesResponseModel copyWith({
    List<Category>? categories,
  }) {
    return CategoriesResponseModel(
      categories: categories ?? this.categories,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categories': categories.map((x) => x.toMap()).toList(),
    };
  }

  factory CategoriesResponseModel.fromMap(Map<String, dynamic> map) {
    return CategoriesResponseModel(
      categories: List<Category>.from(
        (map['categories'] as List<int>).map<Category>(
          (x) => Category.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoriesResponseModel.fromJson(String source) =>
      CategoriesResponseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  factory CategoriesResponseModel.fromList(List<dynamic> list) {
    return CategoriesResponseModel(
        categories: list.map((e) => Category.fromJson(e)).toList());
  }

  @override
  String toString() => 'CategoriesResponseModel(categories: $categories)';

  @override
  bool operator ==(covariant CategoriesResponseModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return listEquals(other.categories, categories);
  }

  @override
  int get hashCode => categories.hashCode;
}

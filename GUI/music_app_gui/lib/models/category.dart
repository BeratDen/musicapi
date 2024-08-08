// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Category {
  final int id;
  final String name;
  final String value;
  final String description;
  final String slug;
  final DateTime createdAt;
  final DateTime updatedAt;
  Category({
    required this.id,
    required this.name,
    required this.value,
    required this.description,
    required this.slug,
    required this.createdAt,
    required this.updatedAt,
  });

  Category copyWith({
    int? id,
    String? name,
    String? value,
    String? description,
    String? slug,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      value: value ?? this.value,
      description: description ?? this.description,
      slug: slug ?? this.slug,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'value': value,
      'description': description,
      'slug': slug,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as int,
      name: map['name'] as String,
      value: map['value'] as String,
      description: map['description'] as String,
      slug: map['slug'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Category(id: $id, name: $name, value: $value, description: $description, slug: $slug, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Category other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.value == value &&
        other.description == description &&
        other.slug == slug &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        value.hashCode ^
        description.hashCode ^
        slug.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}

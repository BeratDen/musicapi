// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserResponseModel {
  int? id;
  String? value;
  String? username;
  String? email;
  UserResponseModel({
    this.id,
    this.value,
    this.username,
    this.email,
  });

  UserResponseModel copyWith({
    int? id,
    String? value,
    String? username,
    String? email,
  }) {
    return UserResponseModel(
      id: id ?? this.id,
      value: value ?? this.value,
      username: username ?? this.username,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'value': value,
      'username': username,
      'email': email,
    };
  }

  factory UserResponseModel.fromMap(Map<String, dynamic> map) {
    return UserResponseModel(
      id: map['id'] != null ? map['id'] as int : null,
      value: map['value'] != null ? map['value'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserResponseModel.fromJson(String source) =>
      UserResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserResponseModel(id: $id, value: $value, username: $username, email: $email)';
  }

  @override
  bool operator ==(covariant UserResponseModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.value == value &&
        other.username == username &&
        other.email == email;
  }

  @override
  int get hashCode {
    return id.hashCode ^ value.hashCode ^ username.hashCode ^ email.hashCode;
  }
}

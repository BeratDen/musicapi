class User {
  String id;
  String value;
  String username;
  String email;

  static User _instance = User._(id: "", value: "", username: "", email: "");

  User._(
      {required this.id,
      required this.username,
      required this.email,
      required this.value});

  static User getInstance() {
    if (_instance == null) {
      _instance = User._(id: "", username: "", email: "", value: "");
    }
    return _instance;
  }

  // const User({required this.id, required this.username, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    try {
      _instance.id = json["id"].toString();
      _instance.username = json["username"];
      _instance.email = json["email"];
      _instance.value = json["value"];
      return _instance;
    } catch (e) {
      throw FormatException('Failed to fetch user. Error: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      id: _instance.id,
      username: _instance.username,
      email: _instance.email,
      value: _instance.value,
    };
  }
}

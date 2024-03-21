class Artist {
  final String? firstName;
  final String? lastName;
  final String? resume;
  final String? avatar;
  final List<String>? categories;
  final List<String>? albums;
  final List<String>? musics;

  const Artist(
      {this.firstName,
      this.lastName,
      this.resume,
      this.avatar,
      this.categories,
      this.albums,
      this.musics});

  factory Artist.fromJson(Map<String, dynamic> json) {
    try {
      final List<dynamic> categoriesJson = json['category'];
      final List<dynamic> albumsJson = json['albums'];
      final List<dynamic> musicsJson = json['musics'];
      // Eğer "category" dizisi yoksa veya boşsa, boş bir liste döndür
      if (categoriesJson.isEmpty && albumsJson.isEmpty && musicsJson.isEmpty) {
        return Artist(
          firstName: json['first_name'],
          lastName: json['last_name'],
          resume: json['resume'],
          avatar: json['avatar'],
          categories: [],
          albums: [],
          musics: [],
        );
      }

      // "category" dizisini String listesine dönüştür
      final List<String> categories = categoriesJson.map((category) {
        return category.toString();
      }).toList();
      final List<String> albums = albumsJson.map((category) {
        return category.toString();
      }).toList();
      final List<String> musics = musicsJson.map((category) {
        return category.toString();
      }).toList();

      return Artist(
          firstName: json['first_name'],
          lastName: json['last_name'],
          resume: json['resume'],
          avatar: json['avatar'],
          categories: categories,
          albums: albums,
          musics: musics);
    } catch (e) {
      throw FormatException('Failed to fetch artist. Error: $e');
    }
  }
}

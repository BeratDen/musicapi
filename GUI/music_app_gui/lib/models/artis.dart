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
}

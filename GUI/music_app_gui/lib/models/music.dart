class Music {
  final String name;
  final String value;
  final String? lyrics;
  final String artist;
  final String artistName;
  final String? musicUrl;
  final String? imageUrl;
  final String? videoUrl;
  final DateTime releaseDate;
  final int stars;
  final List<String> categories;
  final List<String> albums;

  const Music({
    required this.name,
    required this.value,
    required this.lyrics,
    required this.artist,
    required this.artistName,
    this.musicUrl,
    this.imageUrl,
    this.videoUrl,
    required this.releaseDate,
    required this.stars,
    required this.categories,
    required this.albums,
  });

  factory Music.fromJson(Map<String, dynamic> json) {
    try {
      final dynamic categoriesJson = json['category'];
      final dynamic albumsJson = json['albums'];
      List<String> localCategories;
      List<String> localAlbums;
      if (categoriesJson == null || categoriesJson.isEmpty) {
        return Music(
          name: json['name'],
          value: json['value'],
          lyrics: json['lyrics'],
          artist: json['artist'],
          artistName: json['artist_name'],
          musicUrl: json['music_url'],
          imageUrl: json['image_url'],
          videoUrl: json['video_url'],
          releaseDate: DateTime.parse(json['release_date']),
          stars: int.parse(json['num_stars'].toString()),
          albums: [],
          categories: [],
        );
      }

      if (categoriesJson is List && albumsJson is List) {
        // "category" is a list of strings
        localCategories = List<String>.from(
            categoriesJson.map((category) => category.toString()));
        localAlbums = List<String>.from(albumsJson.map((e) => e.toString()));
      } else {
        // "category" is a single item (string or null)
        localCategories = [categoriesJson?.toString() ?? ''];
        localAlbums = [albumsJson?.toString() ?? ''];
      }

      return Music(
          name: json['name'],
          value: json['value'],
          lyrics: json['lyrics'],
          artist: json['artist'],
          artistName: json['artist_name'],
          musicUrl: json['music_url'] ?? '',
          imageUrl: json['image_url'] ?? '',
          videoUrl: json['video_url'] ?? '',
          releaseDate: DateTime.parse(json['release_date']),
          stars: int.parse(json['num_stars'].toString()),
          categories: localCategories,
          albums: localAlbums);
    } catch (e) {
      throw FormatException('Failed to fetch music. Error: $e');
    }
  }

  @override
  String toString() {
    return 'Music name : $name, Artist Name : , Artist : $artist, Music Url : $musicUrl, Image Url : $imageUrl, Video Url : $videoUrl, Release Date : $releaseDate, Stars : $stars ';
  }
}

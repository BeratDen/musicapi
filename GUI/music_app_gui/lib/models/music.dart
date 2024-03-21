class Music {
  final String name;
  final String? lyrics;
  final String artist;
  final String artistName;
  final String album;
  final String? musicUrl;
  final String? imageUrl;
  final String? videoUrl;
  final DateTime releaseDate;
  final int stars;
  final List<String> categories;

  const Music({
    required this.name,
    required this.lyrics,
    required this.artist,
    required this.artistName,
    required this.album,
    this.musicUrl,
    this.imageUrl,
    this.videoUrl,
    required this.releaseDate,
    required this.stars,
    required this.categories,
  });

  factory Music.fromJson(Map<String, dynamic> json) {
    try {
      final dynamic categoriesJson = json['category'];
      List<String> categories;
      if (categoriesJson == null || categoriesJson.isEmpty) {
        return Music(
          name: json['name'],
          lyrics: json['lyrics'],
          artist: json['artist'],
          artistName: json['artist_name'],
          album: json['album'],
          musicUrl: json['music_url'],
          imageUrl: json['image_url'],
          videoUrl: json['video_url'],
          releaseDate: DateTime.parse(json['release_date']),
          stars: int.parse(json['num_stars'].toString()),
          categories: [],
        );
      }

      if (categoriesJson is List) {
        // "category" is a list of strings
        categories = List<String>.from(
            categoriesJson.map((category) => category.toString()));
      } else {
        // "category" is a single item (string or null)
        categories = [categoriesJson?.toString() ?? ''];
      }

      return Music(
        name: json['name'],
        lyrics: json['lyrics'],
        artist: json['artist'],
        artistName: json['artist_name'],
        album: json['album'],
        musicUrl: json['music_url'] ?? '',
        imageUrl: json['image_url'] ?? '',
        videoUrl: json['video_url'] ?? '',
        releaseDate: DateTime.parse(json['release_date']),
        stars: int.parse(json['num_stars'].toString()),
        categories: categories,
      );
    } catch (e) {
      throw FormatException('Failed to fetch music. Error: $e');
    }
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Music name : $name, Artist Name : , Artist : $artist, Album : $album, Music Url : $musicUrl, Image Url : $imageUrl, Video Url : $videoUrl, Release Date : $releaseDate, Stars : $stars ';
  }
}

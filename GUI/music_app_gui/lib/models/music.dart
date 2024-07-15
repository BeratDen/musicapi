import 'package:youtube_explode_dart/youtube_explode_dart.dart';

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
  final bool isFromYouTube;

  const Music(
      {required this.name,
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
      this.isFromYouTube = false});

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

  static Future<List<Music>> fromYouTubeJson(Map<String, dynamic> json) async {
    try {
      final List<dynamic> items = json['items'];
      if (items.isEmpty) {
        throw const FormatException('No items found in the YouTube response.');
      }

      List<Music> musicList = await Future.wait(items.map((item) async {
        final snippet = item['snippet'];
        final videoId = item['id']['videoId'];

        return Music(
          name: snippet['title'],
          value: 'default',
          lyrics: null,
          artist: snippet['channelTitle'],
          artistName: snippet['channelTitle'],
          musicUrl: videoId,
          imageUrl: snippet['thumbnails']['high']['url'],
          videoUrl: videoId,
          releaseDate: DateTime.parse(snippet['publishTime']),
          isFromYouTube: true,
          stars: 0,
          categories: [],
          albums: [],
        );
      }).toList());
      return musicList;
    } catch (e) {
      throw FormatException(
          'Failed to fetch music from YouTube response. Error: $e');
    }
  }

  static Future<String> _getDirectVideoUrl(
      YoutubeExplode yt, String videoId) async {
    try {
      var video = await yt.videos.get(videoId);
      var manifest = await yt.videos.streamsClient.getManifest(videoId);
      var streamInfo = manifest.muxed.bestQuality;
      return streamInfo.url.toString();
        } catch (e) {
      print('Error fetching direct video URL: $e');
    }
    return "";
  }

  @override
  String toString() {
    return 'Music name : $name, Artist Name : , Artist : $artist, Music Url : $musicUrl, Image Url : $imageUrl, Video Url : $videoUrl, Release Date : $releaseDate, Stars : $stars ';
  }
}

import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:music_app_gui/models/album.dart';
import 'package:music_app_gui/models/artis.dart';
import 'package:music_app_gui/models/list.dart';
import 'package:http/http.dart' as http;
import 'package:music_app_gui/models/music.dart';
import 'package:music_app_gui/utils/list_utils.dart';

class Request {
  static Future<List<MusicList>> getLists() async {
    List<MusicList> lists = [];
    final response =
        await http.get(Uri.parse('${dotenv.env['SERVER']}/music/lists'));
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        lists.add(MusicList.fromJson(index));
      }
      return lists;
    }
    return lists;
  }

  static Future<List<Music>> formatMusics(List<String> musics) async {
    return await getMusics(musics);
  }

  static Future<List<Music>> getMusics(List<dynamic> listMusics) async {
    List<Music> musics = [];
    for (var url in listMusics) {
      final response = await http.get(Uri.parse(url));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        musics.add(Music.fromJson(data));
      }
    }
    return musics;
  }

  static Future<List<Music>> getMusicsByParam(String search) async {
    List<Music> musics = [];
    final response = await http.get(
        Uri.parse('${dotenv.env['SERVER']}/music/musics/?search=${search}'));
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        musics.add(Music.fromJson(index));
      }
      return musics;
    }
    return musics;
  }

  static Future<List<Album>> getAlbums() async {
    List<Album> albums = [];
    final response =
        await http.get(Uri.parse('${dotenv.env['SERVER']}/music/albums'));
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        albums.add(Album.fromJson(index));
      }
      return albums;
    }
    return albums;
  }

  static Future<Artist> getArtist(String uri) async {
    Artist artist = Artist();
    Uri url = Uri.parse(uri);
    final response = await http.get(url);
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      artist = Artist.fromJson(data);
      return artist;
    }
    return artist;
  }

  /// The function `_fixString` processes a JSON-like string by adding double quotes around keys and values, excluding URLs
  /// and handling special cases for URLs and the key "artist".
  ///
  /// Args:
  ///   jsonString (String): The `_fixString` method you provided takes a JSON string as input, processes it by adding
  /// double quotes around keys and values (excluding URLs), and then returns the modified JSON string.
  ///
  /// Returns:
  ///   The `_fixString` method takes a JSON string as input, removes the leading and trailing curly braces, adds double
  /// quotes around keys and values (excluding URLs), and then returns the modified JSON string with the key-value pairs
  /// enclosed in curly braces.
  static String _fixString(String jsonString) {
    // Remove leading and trailing curly braces
    jsonString = jsonString.substring(1, jsonString.length - 1);

    // Split the string into key-value pairs
    List<String> keyValuePairs = jsonString.split(', ');

    // Add double quotes around keys and values, excluding URLs
    keyValuePairs = keyValuePairs.map((pair) {
      List<String> parts = pair.split(':');
      String key = parts[0].trim();
      String value = parts[1].trim();

      // Check if the value is a URL using Uri.tryParse
      Uri? uri = Uri.tryParse(value);

      // If it's a URL or key is 'artist', handle it as a special case
      if (uri != null && (key == 'artist')) {
        return '"$key": "$value"';
      } else {
        return '"$key": $value';
      }
    }).toList();

    return '{' + keyValuePairs.join(', ') + '}';
  }
}

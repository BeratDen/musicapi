import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:music_app_gui/models/album.dart';
import 'package:music_app_gui/models/artis.dart';
import 'package:music_app_gui/models/list.dart';
import 'package:music_app_gui/models/music.dart';
import 'package:music_app_gui/utils/dio_client.dart';

class Request {
  static Future<List<MusicList>> getLists() async {
    List<MusicList> lists = [];
    final response =
        await DioClient.dio.get('${dotenv.env['SERVER']}/music/lists');
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in response.data) {
        lists.add(MusicList.fromJson(index));
      }
      return lists;
    }
    return lists;
  }

  static Future<List<Music>> getMusics(
      List<dynamic>? listMusics, List<dynamic>? listFeats) async {
    List<Music> musics = [];
    if (listMusics!.isNotEmpty) {
      for (var url in listMusics) {
        final response = await DioClient.dio.get(url);
        if (response.statusCode == 200) {
          musics.add(Music.fromJson(response.data));
        }
      }
    }
    if (listFeats!.isNotEmpty) {
      for (var url in listFeats) {
        final response = await DioClient.dio.get(url);
        if (response.statusCode == 200) {
          musics.add(Music.fromJson(response.data));
        }
      }
    }

    return musics;
  }

  static Future<List<Music>> getMusicsByParam(String search) async {
    List<Music> musics = [];
    final response = await DioClient.dio
        .get('${dotenv.env['SERVER']}/music/musics/?search=$search');
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in response.data) {
        musics.add(Music.fromJson(index));
      }
      return musics;
    }
    return musics;
  }

  static Future<List<Album>> getAlbums() async {
    List<Album> albums = [];
    final response =
        await DioClient.dio.get('${dotenv.env['SERVER']}/music/albums');
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in response.data) {
        albums.add(Album.fromJson(index));
      }
      return albums;
    }
    return albums;
  }

  static Future<List<Artist>> getArtists() async {
    List<Artist> artists = [];
    final response =
        await DioClient.dio.get('${dotenv.env['SERVER']}/music/musicians');
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in response.data) {
        artists.add(Artist.fromJson(index));
      }
      return artists;
    }
    return artists;
  }

  static Future<Artist> getArtist(String uri) async {
    Artist artist = const Artist();
    final response = await DioClient.dio.get(uri);
    if (response.statusCode == 200) {
      return Artist.fromJson(response.data);
    }
    return artist;
  }
}

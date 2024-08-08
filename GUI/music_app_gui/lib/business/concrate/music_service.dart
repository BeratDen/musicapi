import 'dart:io';

import 'package:music_app_gui/business/abstract/i_music_service.dart';
import 'package:music_app_gui/business/models/musics_response_model.dart';
import 'package:music_app_gui/models/music.dart';
import 'package:music_app_gui/utils/dio_client.dart';

class MusicService extends IMusicService {
  @override
  Future<bool> create(data) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Music> get(String id) async {
    final response = await DioClient.dio.get(id);
    if (response.statusCode == HttpStatus.ok) {
      return Music.fromMap(response.data);
    } else {
      throw UnimplementedError('Failed to fetch music');
    }
  }

  @override
  Future<MusicsResponseModel> list() async {
    final response = await DioClient.dio.get(url);
    if (response.statusCode == HttpStatus.ok) {
      return MusicsResponseModel.fromMap(response.data);
    } else {
      // handle null response with error provider
      throw UnimplementedError('Failed to fetch musics');
    }
  }

  @override
  Future<List<Music>> listByIds(List? ids) async {
    List<Music> musics = [];
    for (var id in ids!) {
      musics.add(await get(id));
    }
    return musics;
  }

  @override
  Future<bool> update(data) {
    // TODO: implement update
    throw UnimplementedError();
  }
}

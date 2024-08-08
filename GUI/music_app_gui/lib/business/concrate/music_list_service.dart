import 'dart:io';

import 'package:flutter/material.dart';
import 'package:music_app_gui/business/abstract/i_music_list_service.dart';
import 'package:music_app_gui/business/models/musics_list_response_model.dart';
import 'package:music_app_gui/models/list.dart';
import 'package:music_app_gui/utils/dio_client.dart';

class MusicListService extends IMusicListService {
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
  Future get(String id) async {
    final response = await DioClient.dio.get(id);
    if (response.statusCode == HttpStatus.ok) {
      return MusicList.fromMap(response.data);
    } else {
      // handle null response with error provider
      throw UnimplementedError('Failed to fetch music');
    }
  }

  @override
  Future<MusicListsResponseModel?> list() async {
    final response = await DioClient.dio.get(url);
    debugPrint(response.toString());
    if (response.statusCode == HttpStatus.ok) {
      return MusicListsResponseModel.fromList(response.data);
    } else {
      // handle null response with error provider
      throw UnimplementedError('Failed to fetch list');
    }
  }

  @override
  Future listByIds(List? ids) {
    // TODO: implement listByIds
    throw UnimplementedError();
  }

  @override
  Future<bool> update(data) {
    // TODO: implement update
    throw UnimplementedError();
  }
}

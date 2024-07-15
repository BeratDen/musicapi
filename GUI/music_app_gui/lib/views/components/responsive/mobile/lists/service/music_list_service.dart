import 'dart:io';

import 'package:flutter/material.dart';
import 'package:music_app_gui/utils/dio_client.dart';
import 'package:music_app_gui/views/components/responsive/mobile/lists/models/musics_list_response_model.dart';

abstract class IMusicListService {
  final String url = "/music/lists/";

  Future<MusicsListResponseModel?> fetchMusicLists();
}

class MusicListService extends IMusicListService {
  @override
  Future<MusicsListResponseModel?> fetchMusicLists() async {
    final response = await DioClient.dio.get(url);
    debugPrint(response.toString());
    if (response.statusCode == HttpStatus.ok) {
      return MusicsListResponseModel.fromList(response.data);
    } else {
      // handle null response with error provider
      throw UnimplementedError('Failed to fetch list');
    }
  }
}

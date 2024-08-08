import 'dart:io';

import 'package:flutter/material.dart';
import 'package:music_app_gui/business/models/albums_response_model.dart';
import 'package:music_app_gui/business/abstract/i_album_service.dart';
import 'package:music_app_gui/models/album.dart';
import 'package:music_app_gui/utils/dio_client.dart';

class AlbumService extends IAlbumService {
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
  Future<Album> get(String id) async {
    final response = await DioClient.dio.get(id);
    if (response.statusCode == HttpStatus.ok) {
      return Album.fromJson(response.data);
    }
    throw ErrorDescription('Failed to fetch album');
  }

  @override
  Future<AlbumListResponseModel> list() async {
    final response = await DioClient.dio.get(url);
    debugPrint(response.toString());
    if (response.statusCode == HttpStatus.ok) {
      return AlbumListResponseModel.fromList(response.data);
    }
    return AlbumListResponseModel(albums: []);
  }

  @override
  Future<bool> update(data) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<AlbumListResponseModel> listByIds(List<dynamic>? ids) async {
    AlbumListResponseModel albumListResponseModel =
        AlbumListResponseModel(albums: []);
    for (var id in ids!) {
      albumListResponseModel.albums.add(await get(id));
    }
    return albumListResponseModel;
  }
}

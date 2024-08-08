import 'dart:io';

import 'package:flutter/material.dart';
import 'package:music_app_gui/business/abstract/i_singer_service.dart';
import 'package:music_app_gui/business/models/singers_response_model.dart';
import 'package:music_app_gui/models/artis.dart';
import 'package:music_app_gui/utils/dio_client.dart';

class SingerService extends ISingerService {
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
  Future<Artist> get(String id) async {
    final response = await DioClient.dio.get(id);
    if (response.statusCode == HttpStatus.ok) {
      return Artist.fromMap(response.data);
    } else {
      throw ErrorDescription('Failed to fetch singer');
    }
  }

  @override
  Future<SingersResponseModel> list() async {
    final response = await DioClient.dio.get(url);
    if (response.statusCode == HttpStatus.ok) {
      return SingersResponseModel.fromList(response.data);
    } else {
      throw ErrorDescription('Failed to fetch singers');
    }
  }

  @override
  Future<List<Artist>> listByIds(List? ids) async {
    List<Artist> artists = [];
    if (ids!.isNotEmpty) {
      for (var id in ids) {
        artists.add(await get(id));
      }
      return artists;
    } else {
      return [];
    }
  }

  @override
  Future<bool> update(data) {
    // TODO: implement update
    throw UnimplementedError();
  }
}

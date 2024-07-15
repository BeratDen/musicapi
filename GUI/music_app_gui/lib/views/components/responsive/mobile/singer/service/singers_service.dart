import 'dart:io';

import 'package:flutter/material.dart';
import 'package:music_app_gui/utils/dio_client.dart';
import 'package:music_app_gui/views/components/responsive/mobile/singer/models/singers_response_model.dart';

abstract class ISingerService {
  final String url = "/music/musicians/";

  Future<SingersResponseModel?> fetchSingers();
}

class SingersService extends ISingerService {
  @override
  Future<SingersResponseModel?> fetchSingers() async {
    final response = await DioClient.dio.get(url);
    debugPrint(response.toString());
    if (response.statusCode == HttpStatus.ok) {
      return SingersResponseModel.fromList(response.data);
    }
    return null;
  }
}

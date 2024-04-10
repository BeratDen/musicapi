import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:music_app_gui/utils/api_client.dart';
import 'package:music_app_gui/utils/dio_client.dart';

class HttpApiClient implements ApiClient {
  @override
  Future<Response<dynamic>> post(String url, Map<String, dynamic> body) async {
    try {
      final response = await DioClient.dio.post(url, data: body);
      return response;
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> get(String url) async {
    /// It looks like there is a typo in the code. The correct line should be `final response = await
    /// DioClient.dio.get(url);`.
    final response = await DioClient.dio.get(url);
    debugPrint(response.statusMessage);
    if (response.statusCode == 200) {
      return jsonEncode(response.data);
    }
    return 'Error';
  }

  @override
  Future<List<dynamic>> list(String url) async {
    final response = await DioClient.dio.get(url);
    debugPrint(response.statusMessage);
    if (response.statusCode == 200) {
      return response.data;
    }
    return [];
  }

  @override
  Future<String> put(String url, Map<String, dynamic> body) async {
    final response = await DioClient.dio.put(url, data: body);
    debugPrint(response.statusMessage);
    if (response.statusCode == 200) {
      return 'Data updated ${response.data.toString()}';
    }
    return 'Error';
  }

  @override
  Future<Response<dynamic>> delete(String url) async {
    try {
      final response = await DioClient.dio.delete(url);
      debugPrint(response.statusMessage);
      return response;
    } on DioException catch (e) {
      // Handle DioException
      throw Exception(e.message);
    }
  }
}

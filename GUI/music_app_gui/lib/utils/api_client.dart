import 'package:dio/dio.dart';

abstract class ApiClient {
  Future<String> get(String url);
  Future<List<dynamic>> list(String url);
  Future<Response<dynamic>> post(String url, Map<String, dynamic> body);
  Future<String> put(String url, Map<String, dynamic> body);
  Future<Response<dynamic>> delete(String url);
}

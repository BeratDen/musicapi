import 'package:dio/dio.dart';

abstract class ApiClient {
  Future<String> get(String url);
  Future<String> list(String url);
  Future<Response<dynamic>> post(String url, Map<String, dynamic> body);
  Future<String> put(String url, Map<String, dynamic> body);
  Future<String> delete(String url);
}

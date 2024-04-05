import 'dart:convert';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';

class Session {
  static final Session _instance = Session._internal();
  Session._internal();
  static Session get instance => _instance;

  Map<String, String> headers = {};
  final dio = Dio();
  final cookieJar = CookieJar();

  Future<Map> get(String uri) async {
    var response = await dio.get(uri);
    // updateCookie(response);
    return response.data;
  }

  Future<Map> post(String uri, dynamic data) async {
    Response response = await dio.post(uri, data: data);
    print(await cookieJar.loadForRequest(Uri.parse(uri)));
    // updateCookie(response);
    return json.decode(response.data);
  }

  // void updateCookie(http.Response response) {
  //   dio.interceptors.add(CookieManager(cookieJar));
  //   print(cookieJar.saveFromResponse(uri, cookies));

  // String? rawCookie = response.headers['set-cookie'];
  // print(response.headers);
  // if (rawCookie != null) {
  //   int index = rawCookie.indexOf(';');
  //   headers['cookie'] =
  //       (index == -1) ? rawCookie : rawCookie.substring(0, index);
  // }
  // print(headers);
  // }
}

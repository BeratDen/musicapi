import 'dart:io';
import 'package:music_app_gui/utils/dio_client.dart';
import 'package:music_app_gui/utils/globals.dart';
import 'package:music_app_gui/views/auth/model/login_request_model.dart';
import 'package:music_app_gui/views/auth/model/login_response_model.dart';

abstract class ILoginService {
  final String url = "/login";

  Future<LoginResponseModel?> fetchLogin(LoginRequestModel model);
}

class LoginService extends ILoginService {
  @override
  Future<LoginResponseModel?> fetchLogin(LoginRequestModel model) async {
    final response = await DioClient.dio.post(
      globalServerUrl + url,
      data: {
        "email": model.email,
        "password": model.password,
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      return LoginResponseModel.fromMap(response.data);
    }

    return null;
  }
}

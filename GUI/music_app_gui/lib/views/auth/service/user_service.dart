import 'dart:io';

import 'package:music_app_gui/utils/dio_client.dart';
import 'package:music_app_gui/views/auth/model/user_response_model.dart';

abstract class IUserService {
  final String url = "/user";

  Future<UserResponseModel?> fetchUser();
}

class UserService extends IUserService {
  @override
  Future<UserResponseModel?> fetchUser() async {
    final response = await DioClient.dio.get(url);
    if (response.statusCode == HttpStatus.ok) {
      return UserResponseModel.fromMap(response.data);
    }
    return null;
  }
}

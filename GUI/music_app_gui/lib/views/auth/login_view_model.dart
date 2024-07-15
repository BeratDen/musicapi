import 'package:flutter/material.dart';
import 'package:music_app_gui/models/user.dart';
import 'package:music_app_gui/providers/user_provider.dart';
import 'package:music_app_gui/views/auth/model/login_request_model.dart';
import 'package:music_app_gui/views/auth/service/login_service.dart';
import 'package:music_app_gui/views/auth/service/user_service.dart';
import 'package:music_app_gui/views/home.dart';

class LoginViewModel extends ChangeNotifier {
  late final LoginService loginService;
  late final UserService userService;
  late final UserProvider userProvider;

  LoginViewModel() {
    loginService = LoginService();
    userService = UserService();
    userProvider = UserProvider();
  }

  Future<void> fetchUserLogin(
      String email, String password, BuildContext context) async {
    final response = await loginService
        .fetchLogin(LoginRequestModel(email: email, password: password));

    if (response != null) {
      // fecth user and create user
      final user = await userService.fetchUser();
      if (user != null) {
        if (!context.mounted) return;
        navigateToHome(context);
      }
      // navigate to home
    } else {
      // show user to response error
    }
  }

  Future<void> checkLogin(BuildContext context) async {
    final response = await userService.fetchUser();
    if (response != null) {
      userProvider.initUser(User(
          id: response.id.toString(),
          email: response.email!,
          username: response.username!,
          value: response.value!));
      if (!context.mounted) return;
      navigateToHome(context);
    }
  }

  void navigateToHome(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (cotnext) => const Home()));
  }
}

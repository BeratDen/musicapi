import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:music_app_gui/models/user.dart';
import 'package:music_app_gui/utils/dio_client.dart';
import 'package:music_app_gui/views/auth/register.dart';
import 'package:music_app_gui/views/components/primary_button.dart';
import 'package:music_app_gui/views/home.dart';
import 'package:dio/dio.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  final _controllerUserMail = TextEditingController();
  final _controllerPassword = TextEditingController();
  var _email = "", _password = "";

  Future<bool> setUpCookies() async {
    try {
      await checkLogin();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: setUpCookies(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please enter email';
                        }
                        return null;
                      },
                      onSaved: (val) => _email = val!,
                      keyboardType: TextInputType.emailAddress,
                      controller: _controllerUserMail,
                      autocorrect: false,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                      onSaved: (val) => _password = val!,
                      controller: _controllerPassword,
                      keyboardType: TextInputType.visiblePassword,
                      autocorrect: false,
                    ),
                    const SizedBox(height: 20),
                    // Login Button
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PrimaryButton(
                            onPressed: () async {
                              if (_formkey.currentState!.validate()) {
                                _formkey.currentState!.save();
                                const snackBar = SnackBar(
                                    duration: Duration(seconds: 30),
                                    content: Row(
                                      children: [
                                        CircularProgressIndicator(),
                                        Text("Logging In...")
                                      ],
                                    ));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                await Future.delayed(
                                    const Duration(seconds: 2));
                                try {
                                  var response = await DioClient.dio.post(
                                      '${dotenv.env['SERVER']}/login',
                                      data: {
                                        "email": _email,
                                        "password": _password
                                      });
                                  if (response.statusCode == 200) {
                                    if (!context.mounted) return;
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => const Home()));
                                  }
                                } on DioException catch (e) {
                                  debugPrint("error : ${e.response?.data}");
                                }
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                              }
                            },
                            child: const Text('Log in')),
                        PrimaryButton(
                            onPressed: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Register(),
                                      ))
                                },
                            child: const Text('Register'))
                      ],
                    ),
                  ],
                ),
              );
            }
            return const Text('Loading');
          },
        ),
      ),
    );
  }

  Future<void> checkLogin() async {
    try {
      var response = await DioClient.dio.get('${dotenv.env['SERVER']}/user');
      if (response.statusCode == 200) {
        final user = User.fromJson(response.data);
        if (!context.mounted) return;
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const Home()));
        debugPrint('Current user : ${user.toString()}');
      }
    } on DioException catch (e) {
      debugPrint('User has no session');

      debugPrint("Status code: ${e.response?.statusCode}");
    }
  }
}

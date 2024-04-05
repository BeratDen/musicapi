import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:music_app_gui/models/user.dart';
import 'package:music_app_gui/utils/crud_repository.dart';
import 'package:music_app_gui/utils/http_api_client.dart';
import 'package:music_app_gui/views/auth/login_screen.dart';
import 'package:music_app_gui/views/components/primary_button.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final HttpApiClient apiClient = HttpApiClient();
  late CrudRepository<User> userRepo;
  final _formkey = GlobalKey<FormBuilderState>();
  final dio = Dio();

  @override
  void initState() {
    super.initState();
    userRepo = CrudRepository('${dotenv.env['SERVER']}/register', apiClient);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FormBuilder(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FormBuilderTextField(
                name: 'username',
                decoration: const InputDecoration(labelText: 'Username'),
                validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()]),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
              ),
              FormBuilderTextField(
                name: 'email',
                decoration: const InputDecoration(labelText: 'Email'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email()
                ]),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
              ),
              FormBuilderTextField(
                name: 'password',
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.match(
                      "^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*?[0-9])[a-zA-Z\d]{8,}",
                      errorText:
                          'Password must have at least minimum eight characters, at least one uppercase letter, one lowercase letter and one number.'),
                ]),
                keyboardType: TextInputType.visiblePassword,
                autocorrect: false,
              ),
              FormBuilderTextField(
                name: 'rePassword',
                decoration: const InputDecoration(labelText: 'Re Password'),
                obscureText: true,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please enter re password';
                  } else if (_formkey.currentState?.fields['password']?.value !=
                      val) {
                    debugPrint(
                        _formkey.currentState?.fields['password']?.value);
                    return 'Passwords do not match';
                  }
                  return null;
                },
                keyboardType: TextInputType.visiblePassword,
                autocorrect: false,
              ),
              const SizedBox(height: 20),
              // Login Button
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
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      await Future.delayed(const Duration(seconds: 2));
                      try {
                        _formkey.currentState!.save();
                        await userRepo.create(_formkey.currentState!.value);
                        if (!context.mounted) return;
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const LoginScreen()));
                      } on DioException catch (e) {
                        debugPrint("error : ${e.response?.data}");
                      }
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    }
                  },
                  child: const Text('Register')),
            ],
          ),
        ),
      ),
    );
  }
}

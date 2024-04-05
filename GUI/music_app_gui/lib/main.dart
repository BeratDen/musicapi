import 'package:flutter/material.dart';
import 'package:music_app_gui/utils/dio_client.dart';
import 'package:music_app_gui/views/auth/login_screen.dart';
import 'package:music_app_gui/views/components/video_player/video_bar_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:io';
import 'package:provider/provider.dart';

Future main() async {
  await dotenv.load(fileName: '.env');
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      WidgetsFlutterBinding.ensureInitialized();
      await DioClient.init();
      runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => AudioPlayerProvider(),
          ),
        ],
        child: const MainApp(),
      ));
    }
  } catch (e) {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(const ConnectionNotFound());
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const LoginScreen(),
      },
    );
  }
}

class ConnectionNotFound extends StatelessWidget {
  const ConnectionNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Text('Connection not found'),
    );
  }
}

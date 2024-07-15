import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:music_app_gui/providers/user_provider.dart';
import 'package:music_app_gui/providers/video_bar_provider.dart';
import 'package:music_app_gui/utils/dio_client.dart';
import 'package:music_app_gui/utils/globals.dart';
import 'package:music_app_gui/views/auth/login_view.dart';
import 'package:music_app_gui/views/auth/login_view_model.dart';
import 'package:provider/provider.dart';
import 'dart:io';

// Platforma bağlı sunucu URL'sini alacak fonksiyon

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  globalServerUrl = Platform.isAndroid || Platform.isIOS
      ? dotenv.env['EMU_SERVER']!
      : dotenv.env['SERVER']!;

  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      WidgetsFlutterBinding.ensureInitialized();
      await DioClient.init();
      runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AudioPlayerProvider()),
          ChangeNotifierProvider(create: (_) => LoginViewModel()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
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
        '/': (context) => LoginView(),
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

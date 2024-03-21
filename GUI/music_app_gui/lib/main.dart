import 'package:flutter/material.dart';
import 'package:music_app_gui/views/components/video_player/video_bar_provider.dart';
import 'package:music_app_gui/views/home.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:io';

import 'package:provider/provider.dart';

Future main() async {
  await dotenv.load(fileName: '.env');
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
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
    runApp(const ConnectionNotFound());
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const Home(),
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

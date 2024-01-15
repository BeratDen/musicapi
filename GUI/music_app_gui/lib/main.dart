import 'package:flutter/material.dart';
import 'package:music_app_gui/views/home.dart';

void main() {
  runApp(const MainApp());
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

import 'package:flutter/material.dart';
import 'package:music_app_gui/views/components/responsive/desktop_body.dart';
import 'package:music_app_gui/views/components/responsive/mobile_body.dart';
import 'package:music_app_gui/views/components/responsive/responsive_layout.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
        mobileBody: MobileBody(), desktopBody: DesktopBody());
  }
}

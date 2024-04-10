import 'package:flutter/material.dart';
import 'package:flutter_resizable_container/flutter_resizable_container.dart';
import 'package:music_app_gui/views/components/center_panel.dart';
import 'package:music_app_gui/views/components/left_panel.dart';
import 'package:music_app_gui/views/components/responsive/desktop_layout.dart';
import 'package:music_app_gui/views/components/video_player/video_bar_widget.dart';

class DesktopBody extends StatefulWidget {
  const DesktopBody({super.key});

  @override
  State<DesktopBody> createState() => _DesktopBodyState();
}

class _DesktopBodyState extends State<DesktopBody> {
  @override
  Widget build(BuildContext context) {
    return const DesktopLayout(child: CenterPanel());
  }
}

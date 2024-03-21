import 'package:flutter/material.dart';
import 'package:music_app_gui/views/components/center_panel.dart';
import 'package:music_app_gui/views/components/left_panel.dart';
import 'package:music_app_gui/views/components/video_player/video_bar_widget.dart';

class DesktopBody extends StatefulWidget {
  const DesktopBody({super.key});

  @override
  State<DesktopBody> createState() => _DesktopBodyState();
}

class _DesktopBodyState extends State<DesktopBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(Colors.grey[900]?.value ?? 0xFF000000),
      child: const Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LeftPanel(),
                Expanded(flex: 6, child: CenterPanel()),
                // RightPanel(),
              ],
            ),
          ),
          SizedBox(
            height: 120,
            child: VideoBar(),
          )
        ],
      ),
    );
  }
}

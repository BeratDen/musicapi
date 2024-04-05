import 'package:flutter/material.dart';
import 'package:flutter_resizable_container/flutter_resizable_container.dart';
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
      child: ResizableContainer(
          direction: Axis.vertical,
          dividerWidth: 3,
          dividerColor: Colors.purple,
          children: [
            ResizableChildData(
                child: ResizableContainer(
                    direction: Axis.horizontal,
                    dividerWidth: 3,
                    dividerColor: Colors.brown,
                    children: const [
                      ResizableChildData(
                          minSize: 150,
                          child: Padding(
                              padding: EdgeInsets.all(8), child: LeftPanel()),
                          startingRatio: 0.25),
                      ResizableChildData(
                          child: CenterPanel(), startingRatio: 0.75)
                    ]),
                startingRatio: 0.85),
            const ResizableChildData(
                maxSize: 120, child: VideoBar(), startingRatio: 0.15),
          ]),
    );
  }
}

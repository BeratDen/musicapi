import 'package:flutter/material.dart';
import 'package:flutter_resizable_container/flutter_resizable_container.dart';
import 'package:music_app_gui/views/components/left_panel.dart';
import 'package:music_app_gui/views/components/video_player/video_bar_widget.dart';

class DesktopLayout extends StatefulWidget {
  const DesktopLayout({super.key, required this.child});
  final Widget child;

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(Colors.grey[900]?.value ?? 0xFF000000),
        child: ResizableContainer(
            direction: Axis.vertical,
            dividerWidth: 3,
            dividerColor: Colors.grey[850],
            children: [
              ResizableChildData(
                  child: Center(
                    child: ResizableContainer(
                        direction: Axis.horizontal,
                        dividerWidth: 3,
                        dividerColor: Colors.grey[850],
                        children: [
                          const ResizableChildData(
                              minSize: 150,
                              child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: LeftPanel()),
                              startingRatio: 0.25),
                          ResizableChildData(
                              child: widget.child, startingRatio: 0.75)
                        ]),
                  ),
                  startingRatio: 0.85),
              const ResizableChildData(
                  maxSize: 120,
                  child: Padding(padding: EdgeInsets.all(4), child: VideoBar()),
                  startingRatio: 0.15),
            ]),
      ),
    );
  }
}

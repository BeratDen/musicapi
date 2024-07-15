import 'package:flutter/material.dart';
import 'package:flutter_resizable_container/flutter_resizable_container.dart';
import 'package:music_app_gui/views/components/responsive/dekstop/left_panel.dart';
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
            divider: ResizableDivider(size: 3, color: Colors.grey[850]),
            children: [
              ResizableChild(
                  child: Center(
                    child: ResizableContainer(
                        direction: Axis.horizontal,
                        divider:
                            ResizableDivider(size: 3, color: Colors.grey[850]),
                        children: [
                          const ResizableChild(
                              minSize: 150,
                              child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: LeftPanel()),
                              size: ResizableSize.ratio(0.25)),
                          ResizableChild(
                              child: widget.child,
                              size: const ResizableSize.ratio(0.75))
                        ]),
                  ),
                  size: const ResizableSize.ratio(0.85)),
              const ResizableChild(
                  maxSize: 120,
                  child: Padding(padding: EdgeInsets.all(4), child: VideoBar()),
                  size: ResizableSize.ratio(0.15)),
            ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_resizable_container/flutter_resizable_container.dart';
import 'package:music_app_gui/views/components/center_panel.dart';
import 'package:music_app_gui/views/components/left_panel.dart';
import 'package:music_app_gui/views/components/video_player/video_bar_widget.dart';

class MusicList extends StatefulWidget {
  const MusicList({super.key});

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(Colors.grey[900]?.value ?? 0xFF000000),
        child: Column(
          children: [
            Expanded(
              child: ResizableContainer(
                direction: Axis.horizontal,
                dividerWidth: 3.0,
                dividerColor: Colors.blue,
                children: const [
                  ResizableChildData(
                    startingRatio: 0.25,
                    minSize: 150,
                    child: LeftPanel(),
                  ),
                  ResizableChildData(
                    startingRatio: 0.75,
                    child: CenterPanel(),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 120,
              child: VideoBar(),
            )
          ],
        ),
      ),
    );
  }
}

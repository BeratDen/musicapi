import 'package:flutter/material.dart';
import 'package:flutter_resizable_container/flutter_resizable_container.dart';
import 'package:music_app_gui/views/components/button_holder.dart';
import 'package:music_app_gui/views/components/left_panel_list.dart';

class LeftPanel extends StatefulWidget {
  const LeftPanel({super.key});

  @override
  State<LeftPanel> createState() => _LeftPanelState();
}

class _LeftPanelState extends State<LeftPanel> {
  @override
  Widget build(BuildContext context) {
    return ResizableContainer(
      direction: Axis.vertical,
      dividerWidth: 3,
      dividerColor: Colors.green,
      children: const [
        ResizableChildData(
          startingRatio: 0.25,
          maxSize: 150,
          minSize: 150,
          child: ButtonHolder(),
        ),
        ResizableChildData(
          startingRatio: 0.75,
          minSize: 150,
          child: LeftPanelList(),
        ),
      ],
    );
  }
}

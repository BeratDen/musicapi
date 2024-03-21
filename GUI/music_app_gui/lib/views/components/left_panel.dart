import 'package:flutter/material.dart';
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
    return const Expanded(
        flex: 2,
        child: Padding(
          padding: EdgeInsets.only(left: 4, top: 0, bottom: 4, right: 4),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    // Button holder
                    ButtonHolder(),
                    // ListView
                    LeftPanelList()
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

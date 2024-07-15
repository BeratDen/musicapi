import 'package:flutter/material.dart';
import 'package:music_app_gui/views/components/responsive/dekstop/center_panel.dart';
import 'package:music_app_gui/views/components/responsive/dekstop/desktop_layout.dart';

class DesktopBody extends StatefulWidget {
  const DesktopBody({super.key});

  @override
  State<DesktopBody> createState() => _DesktopBodyState();
}

class _DesktopBodyState extends State<DesktopBody> {
  @override
  Widget build(BuildContext context) {
    return DesktopLayout(
        child: ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 1264.0,
        minHeight: 681.0,
      ),
      child: const CenterPanel(),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:music_app_gui/views/components/responsive/dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget desktopBody;

  ResponsiveLayout({required this.mobileBody, required this.desktopBody});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < mobileWith) {
        return mobileBody;
      } else {
        return desktopBody;
      }
    });
  }
}

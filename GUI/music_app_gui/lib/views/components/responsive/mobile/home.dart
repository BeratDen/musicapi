import 'package:flutter/material.dart';

import 'package:music_app_gui/view_models/home_model.dart';
import 'package:music_app_gui/views/components/responsive/mobile/center_list.dart';
import 'package:music_app_gui/views/components/responsive/mobile/mobile_video_player.dart';
import 'package:music_app_gui/views/components/responsive/mobile/singer/singer_list_view.dart';
import 'package:music_app_gui/views/components/secondary_button.dart';

class MobileHome extends StatefulWidget {
  const MobileHome({super.key});

  @override
  State<MobileHome> createState() => _MobileHomeState();
}

class _MobileHomeState extends State<MobileHome> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(Colors.grey[850]?.value ?? 0xFF000000),
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Color(Colors.grey[900]?.value ?? 0xFF000000),
          automaticallyImplyLeading: false,
          title: SizedBox(
              width: double.infinity,
              child: SecondaryButton(
                  onPressed: () => {},
                  child: const Text(
                    'Ara',
                    style: TextStyle(color: Colors.white),
                  ))),
        ),
        body: const SafeArea(
            top: true,
            child: Column(
              children: [SingerListView(), CenterList(), MobileVideoPlayer()],
            )),
      ),
    );
  }
}

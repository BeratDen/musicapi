import 'package:flutter/material.dart';
import 'package:music_app_gui/views/components/auth.dart';
import 'package:music_app_gui/views/components/recent_list.dart';
import 'package:music_app_gui/views/components/recomended_list.dart';
import 'package:music_app_gui/models/user.dart';
import 'package:music_app_gui/utils/http_api_client.dart';

class CenterPanel extends StatefulWidget {
  const CenterPanel({
    super.key,
  });

  @override
  State<CenterPanel> createState() => _CenterPanelState();
}

class _CenterPanelState extends State<CenterPanel> {
  late HttpApiClient apiClient;
  late Future<User> user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.only(top: 0, left: 4, right: 4, bottom: 4),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                AuthBar(),
                RecentListenedLists(),
                RecomendedLists(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

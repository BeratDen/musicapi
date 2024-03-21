import 'package:flutter/material.dart';

import 'package:music_app_gui/views/components/artist_info.dart';
import 'package:music_app_gui/views/components/music_card.dart';

class RightPanel extends StatelessWidget {
  const RightPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              color: Colors.deepPurple[300],
              child: const Column(
                children: [
                  // Music Info
                  MusicCard(),
                  // Artist Info
                  ArtistInfo(),
                  // Next Song
                  MusicCard()
                ],
              )),
        ));
  }
}

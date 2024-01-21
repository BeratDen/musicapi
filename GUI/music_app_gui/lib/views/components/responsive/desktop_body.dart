import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:music_app_gui/models/album.dart';
import 'package:music_app_gui/models/artis.dart';
import 'package:music_app_gui/models/category.dart';
import 'package:music_app_gui/models/list.dart';
import 'package:music_app_gui/views/components/artist_card.dart';
import 'package:music_app_gui/views/components/card_view.dart';
import 'package:music_app_gui/views/components/iconed_button.dart';
import 'package:music_app_gui/views/components/left_panel_list.dart';
import 'package:music_app_gui/views/components/primary_button.dart';
import 'package:music_app_gui/views/components/vertical_card.dart';
import 'package:music_app_gui/views/components/video_bar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DesktopBody extends StatelessWidget {
  const DesktopBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: const Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LeftPanel(),
                CenterPanel(),
                RightPanel(),
              ],
            ),
          ),
          SizedBox(
            height: 50,
            child: VideoBar(),
          )
        ],
      ),
    );
  }
}

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
                  CurrentMusicInfo(),
                  // Artist Info
                  ArtistInfo(),
                  // Next Song
                  NextMusicInList()
                ],
              )),
        ));
  }
}

class NextMusicInList extends StatelessWidget {
  const NextMusicInList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: const Card(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}

class ArtistInfo extends StatelessWidget {
  const ArtistInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: const Card(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}

class CurrentMusicInfo extends StatelessWidget {
  const CurrentMusicInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: const Card(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}

class CenterPanel extends StatelessWidget {
  const CenterPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 6,
        child: Padding(
          padding: const EdgeInsets.only(top: 0, left: 4, right: 4, bottom: 4),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  RecentListenedLists(),
                  RecomendedLists(),
                ],
              ),
            ),
          ),
        ));
  }
}

class RecentListenedLists extends StatefulWidget {
  const RecentListenedLists({
    super.key,
  });

  @override
  State<RecentListenedLists> createState() => _RecentListenedListsState();
}

class _RecentListenedListsState extends State<RecentListenedLists> {
  List<MusicList> musicList = [];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: getLists(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.count(
              crossAxisCount: 2,
              childAspectRatio: (1 / .15),
              shrinkWrap: false,
              children: List.generate(musicList.length, (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: VerticalCard(
                    onPressed: () {
                      // Send user to list
                      print('pressed');
                    },
                    imagePath: musicList[index].image,
                    text: musicList[index].name,
                  ),
                );
              }),
            );
          } else {
            return const Text('Loading...');
          }
        },
      ),
    );
  }

  Future<List<MusicList>> getLists() async {
    musicList = [];
    final response =
        await http.get(Uri.parse('${dotenv.env['SERVER']}/music/lists'));
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        musicList.add(MusicList.fromJson(index));
      }
      return musicList;
    }
    return musicList;
  }
}

class RecomendedLists extends StatefulWidget {
  const RecomendedLists({
    super.key,
  });

  @override
  State<RecomendedLists> createState() => _RecomendedListsState();
}

class _RecomendedListsState extends State<RecomendedLists> {
  List<MusicList> lists = [];
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 3,
        child: FutureBuilder(
          future: getLists(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                  child: GridView.count(
                crossAxisCount: 5,
                shrinkWrap: false,
                children: List.generate(lists.length, (index) {
                  return CardView(
                    list: lists[index],
                  );
                }),
              ));
            }
            return const Text('Loading...');
          },
        ));
  }

  Future<List<MusicList>> getLists() async {
    lists = [];
    final response =
        await http.get(Uri.parse('${dotenv.env['SERVER']}/music/lists'));
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        lists.add(MusicList.fromJson(index));
      }
      return lists;
    }
    return lists;
  }
}

class ButtonHolder extends StatelessWidget {
  const ButtonHolder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IconedButton(
              text: 'Anasayfa',
              onPressed: () {},
              icon: Icons.home,
            ),
            IconedButton(
              text: 'Ara',
              onPressed: () {},
              icon: Icons.search,
            ),
          ],
        ),
      ),
    );
  }
}

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
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: ButtonHolder(),
                    ),
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

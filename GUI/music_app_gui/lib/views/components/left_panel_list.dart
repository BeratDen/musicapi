import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:music_app_gui/models/album.dart';
import 'package:music_app_gui/models/artis.dart';
import 'package:music_app_gui/models/music.dart';
import 'package:music_app_gui/views/components/artist_card.dart';
import 'package:http/http.dart' as http;

class LeftPanelList extends StatefulWidget {
  const LeftPanelList({super.key});

  @override
  State<LeftPanelList> createState() => _LeftPanelListState();
}

class _LeftPanelListState extends State<LeftPanelList> {
  List<Artist> artists = [];
  List<Album> albums = [];

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(left: 1, right: 1, top: 10, bottom: 0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: FutureBuilder(
            future: getArtist(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(children: [
                    ArtistList(artists: artists),
                    AlbumList(albums: albums),
                  ]),
                );
              } else {
                return const Text('Loading');
              }
            }),
      ),
    ));
  }

  Future<List<Artist>> getArtist() async {
    artists = [];
    albums = [];
    final artistResponse =
        await http.get(Uri.parse('${dotenv.env['SERVER']}/music/musicians/'));

    final albumResponse =
        await http.get(Uri.parse('${dotenv.env['SERVER']}/music/albums'));

    var artisData = jsonDecode(utf8.decode(artistResponse.bodyBytes));
    var albumData = jsonDecode(utf8.decode(albumResponse.bodyBytes));
    if (artistResponse.statusCode == 200 && albumResponse.statusCode == 200) {
      for (Map<String, dynamic> index in artisData) {
        artists.add(Artist.fromJson(index));
      }
      for (Map<String, dynamic> index in albumData) {
        albums.add(Album.fromJson(index));
      }
      return artists;
    } else {
      return artists;
    }
  }
}

class ArtistList extends StatelessWidget {
  const ArtistList({
    super.key,
    required this.artists,
  });

  final List<Artist> artists;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: artists.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(
              left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: ArtistCard(
              url: artists[index].avatar ?? '',
              artistName:
                  '${artists[index].firstName} ${artists[index].lastName}',
            ),
          ),
        );
      },
    );
  }
}

class AlbumList extends StatelessWidget {
  const AlbumList({
    super.key,
    required this.albums,
  });

  final List<Album> albums;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: albums.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(
              left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: ArtistCard(
              url: albums[index].image,
              artistName: albums[index].name,
            ),
          ),
        );
      },
    );
  }
}

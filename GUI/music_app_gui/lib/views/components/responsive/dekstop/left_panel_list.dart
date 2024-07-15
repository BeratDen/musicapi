import 'package:flutter/material.dart';
import 'package:music_app_gui/utils/request.dart';
import 'package:music_app_gui/views/components/responsive/dekstop/album_card.dart';
import 'package:music_app_gui/views/components/responsive/dekstop/artist_card.dart';

class LeftPanelList extends StatefulWidget {
  const LeftPanelList({super.key});

  @override
  State<LeftPanelList> createState() => _LeftPanelListState();
}

class _LeftPanelListState extends State<LeftPanelList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 1, right: 1, top: 10, bottom: 0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(children: const [
            ArtistList(),
            AlbumList(),
          ]),
        ),
      ),
    );
  }
}

class ArtistList extends StatelessWidget {
  const ArtistList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Request.getArtists(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 0, top: 10, right: 0, bottom: 0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Column(
                  children: List.generate(snapshot.data!.length, (index) {
                return Padding(
                    padding: const EdgeInsets.only(
                        left: 0.0, top: 5.0, right: 0.0, bottom: 0.0),
                    child: ArtistCard(
                      artist: snapshot.data![index],
                      index: index,
                    ));
              })),
            ),
          );
        }
        return const Text('Loading...');
      },
    );
  }
}

class AlbumList extends StatelessWidget {
  const AlbumList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Request.getAlbums(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(
                  left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Column(
                  children: List.generate(snapshot.data!.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 0.0, top: 5.0, right: 0.0, bottom: 0.0),
                      child: AlbumCard(
                        album: snapshot.data![index],
                      ),
                    );
                  }),
                ),
              ),
            );
          }
          return const Text('Loading...');
        });
  }
}

import 'package:flutter/material.dart';
import 'package:music_app_gui/models/album.dart';
import 'package:music_app_gui/models/list.dart';
import 'package:music_app_gui/models/music.dart';
import 'package:music_app_gui/views/components/album_detail.dart';
import 'package:music_app_gui/views/components/artist_detail.dart';
import 'package:music_app_gui/views/components/list_detail.dart';
import 'package:music_app_gui/views/components/search.dart';
import 'package:music_app_gui/views/components/video_player/video_bar_provider.dart';
import 'package:provider/provider.dart';

class ListUtils {
  static void openList(
      BuildContext context, MusicList list, List<Music> musics) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListDetail(
          list: list,
          musics: musics,
        ),
      ),
    );
  }

  static void openAlbum(BuildContext context, Album album) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AlbumDetail(
          album: album,
        ),
      ),
    );
  }

  static void openArtistDetail(
      BuildContext context, List<Album> albums, List<Music> musics) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ArtistDetail(albums: albums, musics: musics),
        ));
  }

  static void playList(BuildContext context, List<Music> musics) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AudioPlayerProvider>(context, listen: false)
          .setMusics(musics);
    });
  }

  static void openSearch(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Search()));
  }
}

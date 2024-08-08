import 'package:flutter/material.dart';
import 'package:music_app_gui/business/concrate/album_service.dart';
import 'package:music_app_gui/business/concrate/music_service.dart';
import 'package:music_app_gui/business/concrate/singer.service.dart';
import 'package:music_app_gui/models/album.dart';
import 'package:music_app_gui/models/artis.dart';
import 'package:music_app_gui/models/music.dart';
import 'package:music_app_gui/views/components/responsive/mobile/singer/singer_detail_view.dart';

class SingerListViewModel extends ChangeNotifier {
  List<Artist>? _artists;
  Artist? _artist;
  List<Music>? _musics;
  List<Album>? _albums;
  late final SingerService _singersService;
  late final MusicService _musicService;
  late final AlbumService _albumService;

  SingerListViewModel() {
    _singersService = SingerService();
    _musicService = MusicService();
    _albumService = AlbumService();
  }

  // artist getter
  List<Artist>? get artists => _artists;

  // artist setter
  set artists(List<Artist>? artists) {
    if (artists != null) {
      _artists = artists;
      notifyListeners();
    }
  }

  Future<List<Artist>> fetchSingers() async {
    final response = await _singersService.list();
    _artists = response.singers;
    return _artists!;
  }

  void detail(BuildContext context, Artist artist) async {
    if (_artist == null) {
      await fetchDatas(artist);
    } else {
      if (_artist?.value != artist.value) {
        await fetchDatas(artist);
      }
    }
    if (!context.mounted) return;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SingerDetailView(
                artist: _artist!, musics: _musics, albums: _albums)));
  }

  Future<void> fetchDatas(Artist artist) async {
    final response = await _singersService.get(artist.value!);

    _artist = Artist(
        firstName: response.firstName,
        lastName: response.lastName,
        value: response.value,
        avatar: response.avatar,
        categories: response.categories,
        albums: response.albums,
        musics: response.musics,
        feats: response.feats);

    final musicResponse = await _musicService.listByIds(_artist?.musics);
    final albumResponse = await _albumService.listByIds(_artist?.albums);
    _musics = musicResponse;
    _albums = albumResponse.albums;
  }
}

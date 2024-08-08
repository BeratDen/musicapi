import 'package:flutter/material.dart';
import 'package:music_app_gui/business/concrate/music_list_service.dart';
import 'package:music_app_gui/business/concrate/music_service.dart';
import 'package:music_app_gui/models/list.dart';
import 'package:music_app_gui/models/music.dart';
import 'package:music_app_gui/views/components/responsive/mobile/lists/music_list_detail.dart';

class MusicListViewModel extends ChangeNotifier {
  List<MusicList>? _musicList;
  List<Music>? _musics;
  late final MusicListService _musicListService;
  late final MusicService _musicService;

  MusicListViewModel() {
    _musicListService = MusicListService();
    _musicService = MusicService();
  }

  // music lists getter
  List<MusicList>? get musicLists => _musicList;

  set musicLists(List<MusicList>? musicLists) {
    if (musicLists != null) {
      _musicList = musicLists;
      notifyListeners();
    } else {
      _musicList = [];
    }
  }

  Future<List<MusicList>> fetchMusicList() async {
    final response = await _musicListService.list();
    if (response != null) {
      _musicList = response.musicLists;
      return _musicList!;
    } else {
      // Handle null response or empty list case
      return [];
    }
  }

  void detail(BuildContext context, MusicList list) async {
    final response = await _musicService.listByIds(list.musics);
    _musics = response;
    if (!context.mounted) return;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MusicListDetail(
                  musics: _musics!,
                  list: list,
                )));
  }
}

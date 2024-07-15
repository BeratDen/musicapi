import 'package:flutter/material.dart';
import 'package:music_app_gui/models/list.dart';
import 'package:music_app_gui/views/components/responsive/mobile/lists/service/music_list_service.dart';

class MusicListViewModel extends ChangeNotifier {
  List<MusicList>? _musicList;
  late final MusicListService _musicListService;

  MusicListViewModel() {
    _musicListService = MusicListService();
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
    final response = await _musicListService.fetchMusicLists();
    if (response != null) {
      _musicList = response.musicLists;
      return _musicList!;
    } else {
      // Handle null response or empty list case
      return [];
    }
  }
}

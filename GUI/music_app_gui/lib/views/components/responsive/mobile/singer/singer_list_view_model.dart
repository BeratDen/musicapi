import 'package:flutter/material.dart';
import 'package:music_app_gui/models/artis.dart';
import 'package:music_app_gui/views/components/responsive/mobile/singer/service/singers_service.dart';

class SingerListViewModel extends ChangeNotifier {
  List<Artist>? _artists;
  late final SingersService _singersService;

  SingerListViewModel() {
    _singersService = SingersService();
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
    final response = await _singersService.fetchSingers();
    if (response != null) {
      _artists = response.singers;
      return _artists!;
    } else {
      // Handle null response or empty list case
      return [];
    }
  }
}

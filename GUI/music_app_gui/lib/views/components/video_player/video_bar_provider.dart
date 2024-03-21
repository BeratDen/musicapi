import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app_gui/models/music.dart';

class AudioPlayerProvider with ChangeNotifier {
  late AudioPlayer _player;

  //props
  List<Music>? musics;
  String? imageSource;
  String? songName;
  String? artistName;

  // subscriptions
  Duration? _currentDuration;
  StreamSubscription? _durationSubscription;
  Duration? _currentPosition;
  StreamSubscription? _positionSubscription;
  double? _currentVolume;
  StreamSubscription? _volumeSubscription;

  // constructor
  AudioPlayerProvider() {
    _player = AudioPlayer();
    _durationSubscription = _player.durationStream.listen((duration) {
      _currentDuration = duration;
      notifyListeners();
    });
    _positionSubscription = _player.positionStream.listen((position) {
      _currentPosition = position;
      notifyListeners();
    });
    _volumeSubscription = _player.volumeStream.listen((volume) {
      print(volume);
      _currentVolume = volume;
      notifyListeners();
    });

    _player.playerStateStream.listen((playerState) {
      updateCurrentMusicProperties();
    });
  }

  // getters
  // TODO: study about this getters and setters
  String get durationText =>
      _currentDuration?.toString().split('.').first ?? '';
  String get positionText =>
      _currentPosition?.toString().split('.').first ?? '';
  String get volumeText => _currentVolume?.toString().split('.').first ?? '';
  String get currentImage {
    if (musics != null &&
        _player.currentIndex != null &&
        _player.currentIndex! < musics!.length) {
      if (musics![_player.currentIndex!].imageUrl!.isEmpty) {
        return 'http://127.0.0.1:8000/static/images/404.jpg';
      }
      return musics![_player.currentIndex!].imageUrl!;
    } else {
      // Handle the case where musics or currentIndex is null or out of bounds
      return 'http://127.0.0.1:8000/static/images/404.jpg'; // Provide a default value or handle the situation accordingly
    }
  }

  String get currentSongName {
    if (musics != null &&
        _player.currentIndex != null &&
        _player.currentIndex! < musics!.length) {
      return musics![_player.currentIndex!].name;
    } else {
      // Handle the case where musics or currentIndex is null or out of bounds
      return '404'; // Provide a default value or handle the situation accordingly
    }
  }

  String get currentArtist {
    if (musics != null &&
        _player.currentIndex != null &&
        _player.currentIndex! < musics!.length) {
      return musics![_player.currentIndex!].artistName;
    } else {
      // Handle the case where musics or currentIndex is null or out of bounds
      return '404'; // Provide a default value or handle the situation accordingly
    }
  }

  double get totalDurationInMili =>
      _currentDuration?.inMilliseconds.toDouble() ?? 0;
  double get positionInMili => _currentPosition?.inMilliseconds.toDouble() ?? 0;
  double get volumeValue => _currentVolume?.clamp(0.0, 1.0).toDouble() ?? 0;

  bool get isPlaying => _player.playing;

  //methods

  void setUrl(List<AudioSource> listSources, int index) async {
    try {
      final playlist = ConcatenatingAudioSource(
          children: listSources,
          useLazyPreparation: true,
          shuffleOrder: DefaultShuffleOrder());
      await _player.setAudioSource(playlist,
          initialIndex: index, initialPosition: Duration.zero);
      await _player.setLoopMode(LoopMode.all);
      _player.play();
      // updateCurrentMusicProperties();
    } catch (e) {
      throw Exception(e);
    }
  }

  void setMusics(List<Music> musics, {int index = 0}) {
    this.musics = musics;
    try {
      List<AudioSource> playlist = [];
      for (Music music in musics) {
        if (music.musicUrl!.isNotEmpty && music.musicUrl != "") {
          playlist.add(AudioSource.uri(Uri.parse(music.musicUrl!)));
        }
      }
      setUrl(playlist, index);
    } catch (e) {
      throw Exception(e);
    }
  }

  void updateCurrentMusicProperties() {
    if (musics != null &&
        _player.currentIndex != null &&
        _player.currentIndex! < musics!.length) {
      // Check if imageUrl is null or empty, and provide a default value if needed
      String imageUrl = "";
      String defaultImageUrl = 'http://127.0.0.1:8000/static/images/404.jpg';
      if (musics![_player.currentIndex!].imageUrl == null ||
          musics![_player.currentIndex!].imageUrl!.isEmpty) {
        imageUrl = defaultImageUrl;
      } else {
        imageUrl = musics![_player.currentIndex!].imageUrl!;
      }

      imageSource = imageUrl;
      songName = musics![_player.currentIndex!].name;
      artistName = musics![_player.currentIndex!].artistName;
      notifyListeners();
    }
  }

  void play() {
    _player.play();
    notifyListeners();
  }

  void next() {
    _player.seekToNext();
    notifyListeners();
  }

  void previous() {
    _player.seekToPrevious();
    notifyListeners();
  }

  void shuffle(bool shuffle) {
    _player.setShuffleModeEnabled(shuffle);
    notifyListeners();
  }

  void loop(LoopMode mode) {
    _player.setLoopMode(mode);
    notifyListeners();
  }

  void pause() {
    _player.pause();
    notifyListeners();
  }

  void onSliderValueChange(double value) {
    _player.seek(Duration(milliseconds: value.round()));
  }

  void onVolumeValueChange(double value) {
    print('incoming value: $value');
    _player.setVolume(value);
  }

  void stop() {
    _player.stop();
    notifyListeners();
  }

  // lifecycle methods

  @override
  void dispose() {
    // TODO: implement dispose
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _volumeSubscription?.cancel();
    super.dispose();
  }
}

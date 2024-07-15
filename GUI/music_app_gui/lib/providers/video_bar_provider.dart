import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app_gui/models/music.dart';
import 'package:music_app_gui/utils/youtube_exploit.dart';

class AudioPlayerProvider with ChangeNotifier {
  late AudioPlayer _player;

  // Properties
  List<Music>? musics;
  String? imageSource;
  String? songName;
  String? artistName;

  // Subscriptions
  Duration? _currentDuration;
  StreamSubscription? _durationSubscription;
  Duration? _currentPosition;
  StreamSubscription? _positionSubscription;
  double? _currentVolume;
  StreamSubscription? _volumeSubscription;

  // Constructor
  AudioPlayerProvider() {
    _player = AudioPlayer();
    _initPlayer();
  }

  // Initialize player and subscriptions
  void _initPlayer() {
    _durationSubscription = _player.durationStream.listen((duration) {
      _currentDuration = duration;
      notifyListeners();
    });
    _positionSubscription = _player.positionStream.listen((position) {
      _currentPosition = position;
      notifyListeners();
    });
    _volumeSubscription = _player.volumeStream.listen((volume) {
      _currentVolume = volume;
      notifyListeners();
    });

    _player.playerStateStream.listen((playerState) {
      _updateCurrentMusicProperties();
    });
  }

  // Getters
  String get durationText =>
      _currentDuration?.toString().split('.').first ?? '';
  String get positionText =>
      _currentPosition?.toString().split('.').first ?? '';
  String get volumeText => _currentVolume?.toString().split('.').first ?? '';

  String get currentImage => _getCurrentImage();

  String get currentSongName => _getCurrentSongName();

  String get currentArtist => _getCurrentArtist();

  double get totalDurationInMili =>
      _currentDuration?.inMilliseconds.toDouble() ?? 0;
  double get positionInMili => _currentPosition?.inMilliseconds.toDouble() ?? 0;
  double get volumeValue => _currentVolume?.clamp(0.0, 1.0).toDouble() ?? 0;

  bool get isPlaying => _player.playing;

  // Methods

  // Set the audio sources and start playback
  Future<void> setMusics(List<Music> musicsList, {int index = 0}) async {
    // TODO: if there is a song within our db there is some error find it and fix it
    musics = musicsList;
    final playlist = ConcatenatingAudioSource(children: []);

    // Get the URL of the chosen song and add it to the beginning of the playlist
    var chosenMusic = musicsList[index];

    if (chosenMusic.musicUrl != null && chosenMusic.musicUrl!.isNotEmpty) {
      String directVideoUrl;
      if (chosenMusic.isFromYouTube) {
        directVideoUrl =
            await YoutubeExploit.getDirectVideoUrl(chosenMusic.musicUrl!);
      } else {
        directVideoUrl = chosenMusic.musicUrl!;
      }
      playlist.add(AudioSource.uri(Uri.parse(directVideoUrl)));
      // update the music list to accordingly
      musics!.removeAt(index);
      musics!.insert(0, chosenMusic);
    }

    // Set the audio source with the playlist and play
    await _player.setAudioSource(playlist);
    await _player.setLoopMode(LoopMode.all);
    await _player.play();
    // Build the rest of the playlist excluding the chosen song
    List<AudioSource> restOfPlaylist =
        await _buildPlaylist(musics!, excludeIndex: 0);

    // Update the playlist
    playlist.addAll(restOfPlaylist);

    // Notify listeners after updating the playlist
    notifyListeners();
  }

// Build the playlist asynchronously excluding the song at 'index'
  Future<List<AudioSource>> _buildPlaylist(List<Music> musicsList,
      {int excludeIndex = -1}) async {
    List<AudioSource> playlist = [];

    for (int i = 0; i < musicsList.length; i++) {
      if (i != excludeIndex) {
        var music = musicsList[i];
        if (music.musicUrl?.isNotEmpty ?? false) {
          if (music.isFromYouTube) {
            var directVideoUrl =
                await YoutubeExploit.getDirectVideoUrl(music.musicUrl!);
            playlist.add(AudioSource.uri(Uri.parse(directVideoUrl)));
          } else {
            playlist.add(AudioSource.uri(Uri.parse(music.musicUrl!)));
          }
        }
      }
    }

    return playlist;
  }

  // Update current music properties
  void _updateCurrentMusicProperties() {
    debugPrint(_player.currentIndex.toString());
    if (musics != null &&
        _player.currentIndex != null &&
        _player.currentIndex! < musics!.length) {
      // Adjust the index to account for the insertion of the first song back
      int currentIndex =
          (_player.currentIndex == 0) ? 0 : _player.currentIndex! - 1;

      String imageUrl = musics![currentIndex].imageUrl ??
          'http://127.0.0.1:8000/static/images/404.jpg';
      imageSource = imageUrl.isEmpty
          ? 'http://127.0.0.1:8000/static/images/404.jpg'
          : imageUrl;
      songName = musics![currentIndex].name;
      artistName = musics![currentIndex].artistName;
      notifyListeners();
    }
  }

  // Playback control methods
  void play() => _player.play();

  void next() => _player.seekToNext();

  void previous() => _player.seekToPrevious();

  void shuffle(bool shuffle) => _player.setShuffleModeEnabled(shuffle);

  void loop(LoopMode mode) => _player.setLoopMode(mode);

  void pause() => _player.pause();

  void stop() => _player.stop();

  void onSliderValueChange(double value) =>
      _player.seek(Duration(milliseconds: value.round()));

  void onVolumeValueChange(double value) => _player.setVolume(value);

  // Cleanup
  @override
  void dispose() {
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _volumeSubscription?.cancel();
    _player.dispose();
    super.dispose();
  }

  // Helper methods

  String _getCurrentImage() {
    if (musics != null &&
        _player.currentIndex != null &&
        _player.currentIndex! < musics!.length) {
      if (musics![_player.currentIndex!].imageUrl!.isEmpty) {
        return 'http://127.0.0.1:8000/static/images/404.jpg';
      }
      return musics![_player.currentIndex!].imageUrl!;
    } else {
      return 'http://127.0.0.1:8000/static/images/404.jpg';
    }
  }

  String _getCurrentSongName() {
    if (musics != null &&
        _player.currentIndex != null &&
        _player.currentIndex! < musics!.length) {
      return musics![_player.currentIndex!].name;
    } else {
      return '404';
    }
  }

  String _getCurrentArtist() {
    if (musics != null &&
        _player.currentIndex != null &&
        _player.currentIndex! < musics!.length) {
      return musics![_player.currentIndex!].artistName;
    } else {
      return '404';
    }
  }
}

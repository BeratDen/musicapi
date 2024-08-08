import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:music_app_gui/providers/video_bar_provider.dart';
import 'package:flutter/material.dart';

class MobileVideoPlayer extends StatefulWidget {
  const MobileVideoPlayer({super.key});

  @override
  State<MobileVideoPlayer> createState() => _MobileVideoPlayerState();
}

class _MobileVideoPlayerState extends State<MobileVideoPlayer> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AudioPlayerProvider>(
        builder: (context, audioPlayerProvider, child) {
      if (audioPlayerProvider.songName != null) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width * 0.25,
              height: MediaQuery.sizeOf(context).width * 0.25,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  audioPlayerProvider.currentImage,
                  width: 300,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      audioPlayerProvider.currentSongName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white, fontFamily: 'Readex Pro'),
                    ),
                    Text(
                      audioPlayerProvider.currentArtist,
                      style: const TextStyle(
                          color: Colors.white, fontFamily: 'Readex Pro'),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.skip_previous,
                                    color: Colors.white, size: 24),
                                onPressed: () {
                                  // Handle previous button pressed
                                  audioPlayerProvider.previous();
                                },
                              ),
                              IconButton(
                                  onPressed: () {
                                    if (audioPlayerProvider.isPlaying) {
                                      audioPlayerProvider.pause();
                                    } else {
                                      audioPlayerProvider.play();
                                    }
                                  },
                                  icon: Icon(
                                    audioPlayerProvider.isPlaying
                                        ? Icons.pause_rounded
                                        : Icons.play_arrow_rounded,
                                    color: Colors.white,
                                    size: 24,
                                  )),
                              IconButton(
                                icon: const Icon(Icons.skip_next,
                                    color: Colors.white, size: 24),
                                onPressed: () {
                                  // Handle forward button pressed
                                  audioPlayerProvider.next();
                                },
                              ),
                            ],
                          ),
                          Flexible(
                            child: LinearPercentIndicator(
                              percent: audioPlayerProvider.percentege,
                              width: MediaQuery.sizeOf(context).width - 108,
                              lineHeight: 12,
                              animation: true,
                              animateFromLastPercent: true,
                              progressColor: Color(Colors.blue.value),
                              backgroundColor: Color(Colors.grey[850]!.value),
                              padding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      } else {
        return Container();
      }
    });
  }
}

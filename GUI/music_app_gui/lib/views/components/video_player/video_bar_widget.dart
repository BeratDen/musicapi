import 'package:flutter/material.dart';
import 'package:music_app_gui/providers/video_bar_provider.dart';
import 'package:provider/provider.dart';

class VideoBar extends StatefulWidget {
  const VideoBar({super.key});

  @override
  State<VideoBar> createState() => _VideoBarState();
}

class _VideoBarState extends State<VideoBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AudioPlayerProvider>(
        builder: (context, audioPlayerProvider, child) {
      return Scaffold(
        body: Container(
          color: Colors.grey[850],
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Section (Music Image, Name, and Artist Name)
              SizedBox(
                width: 300,
                child: Row(
                  children: [
                    Container(
                      width: 100.0,
                      height: 150.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(audioPlayerProvider.currentImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          audioPlayerProvider.currentSongName,
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          audioPlayerProvider.currentArtist,
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Center Section (Back, Stop, Forward Buttons and Progress Bar)
              Expanded(
                child: Column(
                  children: [
                    // Back, Stop, Forward Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.skip_previous,
                              color: Colors.white),
                          onPressed: () {
                            // Handle previous button pressed
                            audioPlayerProvider.previous();
                          },
                        ),
                        const SizedBox(width: 8.0),
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
                            )),
                        const SizedBox(width: 8.0),
                        IconButton(
                          icon:
                              const Icon(Icons.skip_next, color: Colors.white),
                          onPressed: () {
                            // Handle forward button pressed
                            audioPlayerProvider.next();
                          },
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          // Progress Bar Section
                          Row(
                            children: [
                              Text(audioPlayerProvider.positionText,
                                  style: TextStyle(
                                      color: Colors.grey[400])), // Current time

                              Expanded(
                                child: Slider(
                                  max: audioPlayerProvider.totalDurationInMili,
                                  value: audioPlayerProvider.positionInMili,
                                  onChanged:
                                      audioPlayerProvider.onSliderValueChange,
                                ),
                              ),
                              Text(
                                audioPlayerProvider.durationText, // End time
                                style: TextStyle(color: Colors.grey[400]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Right Section (Volume Control Slider)
              SizedBox(
                width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text((audioPlayerProvider.volumeValue * 100)
                        .round()
                        .toString()),
                    SizedBox(
                      width: 150,
                      child: Slider(
                        value: audioPlayerProvider
                            .volumeValue, // Replace with your actual volume value
                        max: 1,
                        label: audioPlayerProvider.volumeValue.toString(),
                        onChanged: audioPlayerProvider.onVolumeValueChange,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

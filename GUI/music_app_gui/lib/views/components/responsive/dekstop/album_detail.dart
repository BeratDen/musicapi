import 'package:flutter/material.dart';
import 'package:music_app_gui/models/album.dart';
import 'package:music_app_gui/models/music.dart';
import 'package:music_app_gui/utils/list_utils.dart';
import 'package:music_app_gui/views/components/responsive/dekstop/left_panel.dart';
import 'package:music_app_gui/providers/video_bar_provider.dart';
import 'package:music_app_gui/views/components/video_player/video_bar_widget.dart';
import 'package:provider/provider.dart';

class AlbumDetail extends StatefulWidget {
  const AlbumDetail({super.key, required this.album});

  @override
  State<AlbumDetail> createState() => _AlbumDetailState();

  final Album album;
}

class _AlbumDetailState extends State<AlbumDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(Colors.grey[900]?.value ?? 0xFF000000),
      body: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const LeftPanel(),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 4, top: 0, bottom: 4, right: 4),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Back Button
                          Row(
                            children: [
                              BackButton(
                                color: Colors.grey[600],
                              ),
                            ],
                          ),
                          // Banner Image Holder
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              height: 300.0,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                image: DecorationImage(
                                  image: NetworkImage(widget.album
                                      .image), // Replace with your banner image
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          // Play Button and Other
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Center(
                                  child: InkWell(
                                    onTap: () => ListUtils.playList(
                                        context, widget.album.musics),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.green,
                                      ),
                                      padding: const EdgeInsets.all(10.0),
                                      child: const Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                        size: 30.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // List of Music Items
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.builder(
                                itemCount: widget.album.musics.length,
                                itemBuilder: (context, index) {
                                  return MusicListItem(
                                    title: widget.album.musics[index].name,
                                    artist:
                                        widget.album.musics[index].artistName,
                                    stars: widget.album.musics[index].stars,
                                    image: widget.album.musics[index].imageUrl,
                                    index: index,
                                    musics: widget.album.musics,
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // RightPanel(),
              ],
            ),
          ),
          const SizedBox(
            height: 120,
            child: VideoBar(),
          )
        ],
      ),
    );
  }
}

class MusicListItem extends StatelessWidget {
  final String title;
  final String artist;
  final int stars;
  final String? image;
  final int index;
  final List<Music> musics;

  const MusicListItem(
      {super.key,
      required this.title,
      required this.artist,
      required this.stars,
      required this.image,
      required this.index,
      required this.musics});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color?>(Colors.grey[800]),
          overlayColor: WidgetStateProperty.all<Color?>(Colors.grey[700]),
          textStyle: WidgetStateProperty.all<TextStyle>(const TextStyle(
              color: Colors.white, fontSize: 10, fontStyle: FontStyle.normal)),
        ),
        onPressed: () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Provider.of<AudioPlayerProvider>(context, listen: false)
                .setMusics(musics, index: index);
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Row(
                  children: [
                    // Music Icon
                    CircleAvatar(
                      backgroundImage: NetworkImage(image!.isEmpty
                          ? 'http://127.0.0.1:8000/static/images/404.jpg'
                          : image!),
                      child: const Icon(Icons.music_note, color: Colors.white),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    // title and subtitle
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style:
                              TextStyle(color: Colors.grey[200], fontSize: 16),
                        ),
                        Text(
                          artist,
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Stars
              Row(
                children: List.generate(
                  stars,
                  (index) => Icon(
                    Icons.star,
                    color: Colors.yellow[400],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

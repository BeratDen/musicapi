import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:music_app_gui/models/album.dart';
import 'package:music_app_gui/models/music.dart';
import 'package:music_app_gui/utils/list_utils.dart';
import 'package:music_app_gui/views/components/left_panel.dart';
import 'package:music_app_gui/views/components/video_player/video_bar_provider.dart';
import 'package:music_app_gui/views/components/video_player/video_bar_widget.dart';
import 'package:provider/provider.dart';

class ArtistDetail extends StatefulWidget {
  const ArtistDetail({super.key, required this.albums, required this.musics});

  @override
  State<ArtistDetail> createState() => _ArtistDetailState();

  final List<Album> albums;
  final List<Music> musics;
}

class _ArtistDetailState extends State<ArtistDetail> {
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
                                  image: NetworkImage(widget.albums.length > 0
                                      ? widget.albums[0].image
                                      : dotenv.env[
                                          '404']!), // Replace with your banner image
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
                                        context, widget.musics),
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
                                itemCount: widget.musics.length,
                                itemBuilder: (context, index) {
                                  return MusicListItem(
                                    title: widget.musics[index].name,
                                    artist: widget.musics[index].artistName,
                                    stars: widget.musics[index].stars,
                                    image: widget.musics[index].imageUrl,
                                    index: index,
                                    musics: widget.musics,
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
          backgroundColor: MaterialStateProperty.all<Color?>(Colors.grey[800]),
          overlayColor: MaterialStateProperty.all<Color?>(Colors.grey[700]),
          textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
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

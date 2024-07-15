import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:music_app_gui/models/album.dart';
import 'package:music_app_gui/models/artis.dart';
import 'package:music_app_gui/models/music.dart';
import 'package:music_app_gui/utils/list_utils.dart';
import 'package:music_app_gui/utils/request.dart';
import 'package:music_app_gui/views/components/primary_button.dart';

class ArtistCard extends StatefulWidget {
  const ArtistCard({super.key, required this.artist, required this.index});
  final Artist artist;
  final int index;

  @override
  State<ArtistCard> createState() => _ArtistCardState();
}

class _ArtistCardState extends State<ArtistCard> {
  List<Album> albums = [];
  List<Music> musics = [];

  @override
  void initState() {
    super.initState();
    getMusics();
  }

  void getMusics() async {
    // todo try to get link of music from backend
    musics = await Request.getMusics(widget.artist.musics, widget.artist.feats);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PrimaryButton(
        onPressed: () => ListUtils.openArtistDetail(context, albums, musics),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(widget.artist.avatar!.isEmpty
                    ? dotenv.env['404']!
                    : widget.artist.avatar!),
              ),
              title: Text(
                '${widget.artist.firstName}  ${widget.artist.lastName}',
                style: TextStyle(
                    color: Colors.grey[200],
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}

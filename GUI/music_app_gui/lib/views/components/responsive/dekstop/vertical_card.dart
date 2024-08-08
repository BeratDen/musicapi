import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:music_app_gui/models/list.dart';
import 'package:music_app_gui/models/music.dart';
import 'package:music_app_gui/utils/list_utils.dart';
import 'package:music_app_gui/utils/request.dart';

class VerticalCard extends StatefulWidget {
  final String? imagePath;
  final String text;
  final MusicList list;

  const VerticalCard(
      {super.key,
      required this.imagePath,
      required this.text,
      required this.list});

  @override
  State<VerticalCard> createState() => _VerticalCardState();
}

class _VerticalCardState extends State<VerticalCard> {
  List<Music> musics = [];
  bool isHover = false;

  @override
  void initState() {
    super.initState();
    setMusics();
  }

  void setMusics() async {
    musics = await Request.getMusics(widget.list.musics, []);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => ListUtils.openList(context, widget.list, musics),
      onHover: (value) {
        setState(() {
          isHover = value;
        });
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(Colors.grey[800]!),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.zero,
        ),
        elevation:
            WidgetStateProperty.all<double>(8.0), // Add elevation for shadow
        shadowColor: WidgetStateProperty.all<Color>(Colors.black),
      ), // Shadow color
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            bottomLeft: Radius.circular(8.0),
          ),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5.0),
                bottomLeft: Radius.circular(5.0),
              ),
              child: Image.network(
                widget.imagePath!.isEmpty
                    ? dotenv.env['404']!
                    : widget.imagePath!,
                width: 100.0, // Adjust the width as needed
                height: 100.0, // Adjust the height as needed
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  widget.text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            if (isHover)
              Center(
                child: AnimatedOpacity(
                  opacity: isHover ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: InkWell(
                    onTap: () => ListUtils.playList(context, musics),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                      padding: const EdgeInsets.all(5.0),
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 15.0,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:music_app_gui/models/list.dart';
import 'package:music_app_gui/models/music.dart';
import 'package:music_app_gui/utils/list_utils.dart';
import 'package:music_app_gui/utils/request.dart';

class CardView extends StatefulWidget {
  const CardView({super.key, required this.list});

  final MusicList list;

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            isHover = true;
          });
        },
        onExit: (_) {
          setState(() {
            isHover = false;
          });
        },
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color?>(Colors.grey[800]),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(color: Colors.grey),
              ),
            ),
          ),
          onPressed: () => ListUtils.openList(context, widget.list, musics),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        widget.list.image,
                        height: 100,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      mouseCursor: SystemMouseCursors.click,
                      title: Text(
                        widget.list.name,
                        style: TextStyle(color: Colors.grey[100]),
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        widget.list.description,
                        style: TextStyle(color: Colors.grey[400]),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              // Hover State
              if (isHover)
                Positioned(
                  bottom: 20,
                  right: 0,
                  child: Center(
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
                          padding: const EdgeInsets.all(10.0),
                          child: const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

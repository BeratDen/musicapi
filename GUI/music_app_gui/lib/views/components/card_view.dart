import 'package:flutter/material.dart';
import 'package:music_app_gui/models/list.dart';

class CardView extends StatefulWidget {
  const CardView({super.key, required this.list});

  final MusicList list;

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color?>(Colors.grey[800]),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(color: Colors.grey)))),
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  widget.list.image,
                  fit: BoxFit.fill,
                ),
              ),
              ListTile(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

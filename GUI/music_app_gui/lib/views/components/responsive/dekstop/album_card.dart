import 'package:flutter/material.dart';
import 'package:music_app_gui/models/album.dart';
import 'package:music_app_gui/views/components/primary_button.dart';
import 'package:music_app_gui/utils/list_utils.dart';

class AlbumCard extends StatefulWidget {
  const AlbumCard({
    super.key,
    required this.album,
  });
  final Album album;

  @override
  State<AlbumCard> createState() => _AlbumCardState();
}

class _AlbumCardState extends State<AlbumCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PrimaryButton(
        onPressed: () => ListUtils.openAlbum(context, widget.album),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(widget.album.image),
              ),
              title: Text(
                widget.album.name,
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

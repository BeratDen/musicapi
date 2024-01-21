import 'package:flutter/material.dart';
import 'package:music_app_gui/views/components/primary_button.dart';

class ArtistCard extends StatefulWidget {
  const ArtistCard({super.key, required this.url, required this.artistName});
  final String url;
  final String artistName;

  @override
  State<ArtistCard> createState() => _ArtistCardState();
}

class _ArtistCardState extends State<ArtistCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PrimaryButton(
        onPressed: () {
          print('pressed');
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(widget.url),
              ),
              title: Text(
                widget.artistName,
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

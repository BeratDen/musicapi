import 'package:flutter/material.dart';

class VideoBar extends StatefulWidget {
  const VideoBar({super.key});

  @override
  State<VideoBar> createState() => _VideoBarState();
}

class _VideoBarState extends State<VideoBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      height: 50,
      child: Center(
        child: Text(
          'Video Oynatma Barı',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

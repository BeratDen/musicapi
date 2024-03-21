import 'package:flutter/material.dart';

class MusicCard extends StatelessWidget {
  const MusicCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: const Card(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}

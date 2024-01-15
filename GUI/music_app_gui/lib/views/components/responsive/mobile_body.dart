import 'package:flutter/material.dart';

class MobileBody extends StatelessWidget {
  const MobileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      body: Column(
        children: [
          // video
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                height: 250,
                color: Colors.deepPurple[400],
              ),
            ),
          ),
          // comment section
          Expanded(
              child: ListView.builder(
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.deepPurple[300],
                        height: 120,
                      ),
                    );
                  })),
        ],
      ),
    );
  }
}

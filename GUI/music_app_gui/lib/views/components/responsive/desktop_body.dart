import 'package:flutter/material.dart';
import 'package:music_app_gui/views/components/video_bar.dart';

class DesktopBody extends StatelessWidget {
  const DesktopBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      body: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      color: Colors.deepPurple[300],
                      child: Column(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                // Button holder
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: ButtonHolder(),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: 8,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          color: Colors.deepPurple[300],
                                          height: 120,
                                          child: Card(
                                            child: Text('test'),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      color: Colors.deepPurple[300], child: Text('test')),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      color: Colors.deepPurple[300], child: Text('test')),
                )),
              ],
            ),
          ),
          Container(
            height: 50,
            child: VideoBar(),
          )
        ],
      ),
    );
  }
}

class ButtonHolder extends StatelessWidget {
  const ButtonHolder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple[200],
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Text('test'),
            ),
            Card(
              child: Text('test'),
            ),
          ],
        ),
      ),
    );
  }
}

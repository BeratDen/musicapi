import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_gui/controller/musics_controller.dart';
import 'package:music_app_gui/views/components/responsive/dekstop/desktop_layout.dart';
import 'package:music_app_gui/views/forms/music/add_music.dart';

class MusicsList extends StatefulWidget {
  const MusicsList({super.key});

  @override
  State<MusicsList> createState() => _MusicsListState();
}

class _MusicsListState extends State<MusicsList> {
  @override
  Widget build(BuildContext context) {
    return DesktopLayout(
        child: Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(4),
            child: IconButton(
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddMusic()));
                },
                icon: const Icon(Icons.add)),
          ),
          Expanded(
            child: GetBuilder<MusicsController>(
              init: MusicsController(),
              builder: (musicController) => musicController.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: musicController.musics.length,
                      itemBuilder: (context, index) {
                        var data = musicController.musics[index];
                        return Padding(
                          padding: const EdgeInsets.all(4),
                          child: Container(
                            decoration: BoxDecoration(color: Colors.grey[800]),
                            child: ListTile(
                              tileColor: Colors.grey[850],
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              leading: Container(
                                padding: const EdgeInsets.only(right: 12),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        right: BorderSide(
                                            width: 1, color: Colors.white24))),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(data
                                          .imageUrl!.isEmpty
                                      ? 'http://127.0.0.1:8000/static/images/404.jpg'
                                      : data.imageUrl!),
                                  child: const Icon(Icons.music_note,
                                      color: Colors.white),
                                ),
                              ),
                              title: Text(
                                data.name,
                                style: TextStyle(
                                    color: Colors.grey[200],
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Row(
                                children: [
                                  const Icon(
                                    Icons.person_outline,
                                    color: Colors.yellowAccent,
                                  ),
                                  Text(
                                    data.artistName,
                                    style: TextStyle(color: Colors.grey[400]),
                                  )
                                ],
                              ),
                              trailing: SizedBox(
                                width: 100,
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.yellow[700],
                                      ),
                                      onPressed: () {
                                        debugPrint('edit test');
                                      },
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          var snackBar = const SnackBar(
                                              duration:
                                                  Duration(seconds: 9999999),
                                              content: Row(
                                                children: [
                                                  CircularProgressIndicator(),
                                                  Text("Deleting Music...")
                                                ],
                                              ));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                          await musicController
                                              .removeItem(data);
                                          if (!musicController
                                              .isLoading.value) {
                                            ScaffoldMessenger.of(context)
                                                .clearSnackBars();
                                          }
                                        },
                                        icon: const Icon(Icons.delete,
                                            color: Colors.red))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          )
        ]),
      ),
    ));
  }
}

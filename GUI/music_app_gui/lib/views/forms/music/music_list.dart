import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:music_app_gui/models/music.dart';
import 'package:music_app_gui/utils/crud_repository.dart';
import 'package:music_app_gui/utils/dio_client.dart';
import 'package:music_app_gui/utils/http_api_client.dart';
import 'package:music_app_gui/views/components/responsive/desktop_layout.dart';
import 'package:music_app_gui/views/forms/music/add_music.dart';

class MusicsList extends StatefulWidget {
  const MusicsList({super.key});

  @override
  State<MusicsList> createState() => _MusicsListState();
}

class _MusicsListState extends State<MusicsList> {
  HttpApiClient apiClient = HttpApiClient();
  late CrudRepository musicRepository;
  late List<Music> musics = [];

  @override
  void initState() {
    super.initState();
    musicRepository =
        CrudRepository('${dotenv.env['SERVER']}/music/musics', apiClient);
    getUserMusics();
  }

  Future<void> getUserMusics() async {
    List<Music> newMusics = [];
    try {
      var response = await DioClient.dio
          .get('${dotenv.env['SERVER']}/music/musics/session');
      if (response.statusCode == 200) {
        for (var music in response.data) {
          newMusics.add(Music.fromJson(music));
        }
        setState(() {
          musics = newMusics;
        });
        debugPrint(musics.toString());
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

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
            child: ListView.builder(
              itemCount: musics.length,
              itemBuilder: (context, index) {
                var data = musics[index];
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
                          backgroundImage: NetworkImage(data.imageUrl!.isEmpty
                              ? 'http://127.0.0.1:8000/static/images/404.jpg'
                              : data.imageUrl!),
                          child:
                              const Icon(Icons.music_note, color: Colors.white),
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
                                  var response =
                                      await musicRepository.delete(data.value);
                                  if (response.statusCode == 204) {
                                    setState(() {
                                      musics.remove(data);
                                    });
                                  }
                                  const snackBar = SnackBar(
                                      content: Row(
                                    children: [
                                      CircularProgressIndicator(),
                                      Text("Deleting Music")
                                    ],
                                  ));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  debugPrint(response.toString());
                                },
                                icon:
                                    const Icon(Icons.delete, color: Colors.red))
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ]),
      ),
    ));
  }
}

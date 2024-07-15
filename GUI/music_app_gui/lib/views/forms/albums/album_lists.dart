import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:music_app_gui/models/album.dart';
import 'package:music_app_gui/utils/crud_repository.dart';
import 'package:music_app_gui/utils/http_api_client.dart';
import 'package:music_app_gui/views/components/responsive/dekstop/desktop_layout.dart';
import 'package:music_app_gui/views/forms/albums/add_album.dart';

class AlbumList extends StatefulWidget {
  const AlbumList({super.key});

  @override
  State<AlbumList> createState() => _AlbumListState();
}

class _AlbumListState extends State<AlbumList> {
  late List<Album> albums;
  HttpApiClient apiClient = HttpApiClient();
  late CrudRepository albumRepository;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    albums = [];
    albumRepository =
        CrudRepository('${dotenv.env['SERVER']}/music/albums', apiClient);
    getAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return DesktopLayout(
        child: Column(
      children: [
        IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddAlbum()));
            },
            icon: const Icon(Icons.add)),
        Expanded(
            child: ListView.builder(
                itemCount: albums.length,
                itemBuilder: (context, index) {
                  if (albums.isNotEmpty) {
                    Album album = albums[index];
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
                              backgroundImage: NetworkImage(album.image.isEmpty
                                  ? 'http://127.0.0.1:8000/static/images/404.jpg'
                                  : album.image),
                              child: const Icon(Icons.music_note,
                                  color: Colors.white),
                            ),
                          ),
                          title: Text(
                            album.name,
                            style: TextStyle(
                                color: Colors.grey[200],
                                fontWeight: FontWeight.bold),
                          ),
                          // subtitle: Row(
                          //   children: [
                          //     const Icon(
                          //       Icons.person_outline,
                          //       color: Colors.yellowAccent,
                          //     ),
                          //     Text(
                          //       album.stars.toString(),
                          //       overflow: TextOverflow.ellipsis,
                          //       style: TextStyle(color: Colors.grey[400]),
                          //     )
                          //   ],
                          // ),
                          trailing: IconButton(
                            onPressed: () {
                              debugPrint('Request update or delete');
                              // TODO: open model for reporting
                            },
                            icon: const Icon(
                              Icons.report_sharp,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return SizedBox(
                      height: 125,
                      width: double.infinity,
                      child: Card(
                        color: Colors.grey[800],
                        child: Center(
                          child: Text(
                            'You have not added any artists',
                            style: TextStyle(color: Colors.grey[200]),
                          ),
                        ),
                      ),
                    );
                  }
                }))
      ],
    ));
  }

  void getAlbums() async {
    var response = await albumRepository.list();
    List<Album> newListAlbum = [];
    for (var album in response) {
      newListAlbum.add(Album.fromJson(album));
    }
    setState(() {
      albums = newListAlbum;
    });
  }
}

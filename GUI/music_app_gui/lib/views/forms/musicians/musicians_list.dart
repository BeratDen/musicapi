import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:music_app_gui/models/artis.dart';
import 'package:music_app_gui/utils/crud_repository.dart';
import 'package:music_app_gui/utils/http_api_client.dart';
import 'package:music_app_gui/views/components/responsive/desktop_layout.dart';
import 'package:music_app_gui/views/forms/musicians/add_artist.dart';

class MusiciansList extends StatefulWidget {
  const MusiciansList({super.key});

  @override
  State<MusiciansList> createState() => _MusiciansListState();
}

class _MusiciansListState extends State<MusiciansList> {
  late List<Artist> artists;
  HttpApiClient apiClient = HttpApiClient();
  late CrudRepository artistRepository;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    artists = [];
    artistRepository =
        CrudRepository('${dotenv.env['SERVER']}/music/musicians', apiClient);
    getArtist();
  }

  @override
  Widget build(BuildContext context) {
    return DesktopLayout(
        child: Column(
      children: [
        IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddArtist()));
            },
            icon: const Icon(Icons.add)),
        Expanded(
          child: ListView.builder(
              itemCount: artists.length,
              itemBuilder: (context, index) {
                if (artists.isNotEmpty) {
                  Artist data = artists[index];
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
                            backgroundImage: NetworkImage(data.avatar!.isEmpty
                                ? 'http://127.0.0.1:8000/static/images/404.jpg'
                                : data.avatar!),
                            child: const Icon(Icons.music_note,
                                color: Colors.white),
                          ),
                        ),
                        title: Text(
                          '${data.firstName!} ${data.lastName}',
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
                              data.resume!,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.grey[400]),
                            )
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            debugPrint('Request update or delete');
                            // TODO: open model for reporting
                          },
                          icon: const Icon(Icons.report_sharp),
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
              }),
        )
      ],
    ));
  }

  void getArtist() async {
    var response = await artistRepository.list();
    List<Artist> artists = [];
    for (var artist in response) {
      artists.add(Artist.fromJson(artist));
    }
    setState(() {
      this.artists = artists;
    });
  }
}

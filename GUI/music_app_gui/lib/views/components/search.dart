import 'package:flutter/material.dart';
import 'package:music_app_gui/models/music.dart';
import 'package:music_app_gui/views/components/album_detail.dart';
import 'package:music_app_gui/views/components/left_panel.dart';
import 'package:music_app_gui/utils/request.dart';
import 'package:music_app_gui/views/components/video_player/video_bar_widget.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _search = GlobalKey<FormState>();
  final inputFieldController = TextEditingController();
  Future<List<Music>>? _futureMusic;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(Colors.grey[900]?.value ?? 0xFF000000),
      body: Column(
        children: [
          Expanded(
              child: Row(
            children: [
              // left Panel
              const LeftPanel(),
              // Search form and results
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 4, top: 0, bottom: 4, right: 4),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              // Search Form
                              Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Form(
                                  key: _search,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[800],
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: TextFormField(
                                        controller: inputFieldController,
                                        onChanged: (value) {
                                          // TODO find a way to send request when user left writing
                                          if (value.length >= 3) {
                                            setState(() {
                                              _futureMusic =
                                                  Request.getMusicsByParam(
                                                      inputFieldController
                                                          .text);
                                            });
                                          }
                                        },
                                        style:
                                            TextStyle(color: Colors.grey[200]),
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            labelText: 'Search',
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                            labelStyle: TextStyle(
                                                color: Colors.grey[300])),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.search))
                            ],
                          ),
                        ),
                        // Search Results //
                        Expanded(
                          child: FutureBuilder<List<Music>>(
                              future: _futureMusic,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasError) {
                                  return Center(
                                    child: Text('Error: ${snapshot.error}'),
                                  );
                                } else if (snapshot.hasData) {
                                  return ListView.builder(
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      return MusicListItem(
                                          title: snapshot.data![index].name,
                                          artist:
                                              snapshot.data![index].artistName,
                                          stars: snapshot.data![index].stars,
                                          image: snapshot.data![index].imageUrl,
                                          index: index,
                                          musics: snapshot.data!);
                                    },
                                  );
                                } else {
                                  return const Center(
                                    child: Text('No data found'),
                                  );
                                }
                              }),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
          const SizedBox(
            height: 120,
            child: VideoBar(),
          )
        ],
      ),
    );
  }
}

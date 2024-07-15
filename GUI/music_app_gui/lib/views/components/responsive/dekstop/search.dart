import 'package:flutter/material.dart';
import 'package:music_app_gui/models/music.dart';
import 'package:music_app_gui/utils/request.dart';
import 'package:music_app_gui/views/components/responsive/dekstop/album_detail.dart';
import 'package:music_app_gui/views/components/responsive/dekstop/left_panel.dart';
import 'package:music_app_gui/views/components/video_player/video_bar_widget.dart';
import 'package:flutter_resizable_container/flutter_resizable_container.dart';

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
      body: Container(
        color: Color(Colors.grey[900]?.value ?? 0xFF000000),
        child: ResizableContainer(
            direction: Axis.vertical,
            divider: ResizableDivider(
                size: 3, color: Color(Colors.grey[900]?.value ?? 0xFF000000)),
            children: [
              ResizableChild(
                  child: ResizableContainer(
                      direction: Axis.horizontal,
                      divider: ResizableDivider(
                          size: 3,
                          color: Color(Colors.grey[900]?.value ?? 0xFF000000)),
                      children: [
                        const ResizableChild(
                            minSize: 150,
                            child: Padding(
                                padding: EdgeInsets.all(8), child: LeftPanel()),
                            size: ResizableSize.ratio(0.25)),
                        ResizableChild(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 4, top: 0, bottom: 4, right: 4),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[850],
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: TextFormField(
                                                    controller:
                                                        inputFieldController,
                                                    onChanged: (value) {},
                                                    style: TextStyle(
                                                        color:
                                                            Colors.grey[200]),
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        labelText: 'Search',
                                                        labelStyle: TextStyle(
                                                            color: Colors
                                                                .grey[300])),
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
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
                                              onPressed: () {
                                                setState(() {
                                                  _futureMusic =
                                                      Request.getMusicsByParam(
                                                          inputFieldController
                                                              .text);
                                                });
                                              },
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
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            } else if (snapshot.hasError) {
                                              return Center(
                                                child: Text(
                                                    'Error: ${snapshot.error}'),
                                              );
                                            } else if (snapshot.hasData) {
                                              return ListView.builder(
                                                itemCount:
                                                    snapshot.data!.length,
                                                itemBuilder: (context, index) {
                                                  return MusicListItem(
                                                      title: snapshot
                                                          .data![index].name,
                                                      artist: snapshot
                                                          .data![index]
                                                          .artistName,
                                                      stars: snapshot
                                                          .data![index].stars,
                                                      image: snapshot
                                                          .data![index]
                                                          .imageUrl,
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
                            size: const ResizableSize.ratio(0.75))
                      ]),
                  size: const ResizableSize.ratio(0.85)),
              const ResizableChild(
                  maxSize: 120,
                  child: VideoBar(),
                  size: ResizableSize.ratio(0.15)),
            ]),
      ),
    );
  }
}

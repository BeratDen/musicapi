import 'package:flutter/material.dart';
import 'package:music_app_gui/models/album.dart';
import 'package:music_app_gui/models/artis.dart';
import 'package:music_app_gui/models/music.dart';
import 'package:music_app_gui/providers/video_bar_provider.dart';
import 'package:music_app_gui/views/components/responsive/mobile/mobile_video_player.dart';
import 'package:provider/provider.dart';

class SingerDetailView extends StatelessWidget {
  const SingerDetailView(
      {super.key,
      required this.artist,
      required this.musics,
      required this.albums});

  final Artist artist;
  final List<Music>? musics;
  final List<Album>? albums;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(Colors.grey[850]?.value ?? 0xFF000000),
      appBar: AppBar(
        backgroundColor: Color(Colors.grey[900]?.value ?? 0xFF000000),
        automaticallyImplyLeading: false,
        leading: BackButton(
          color: Colors.grey.shade200,
        ),
        title: Text(
          "${artist.firstName} ${artist.lastName}",
          style: const TextStyle(color: Colors.white),
        ),
        actions: const [],
        centerTitle: false,
        elevation: 0,
      ),
      body: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(0),
            child: Image.network(
              artist.avatar!,
              width: MediaQuery.sizeOf(context).width,
              height: 200,
              fit: BoxFit.fitWidth,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: musics!.length,
              itemBuilder: (context, index) => (Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Provider.of<AudioPlayerProvider>(context, listen: false)
                          .setMusics(musics!, index: index);
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(8, 8, 12, 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              musics![index].imageUrl ??
                                  'https://picsum.photos/seed/387/600',
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 0, 0),
                                  child: Text(
                                    musics![index].name,
                                    style: TextStyle(
                                        color: Colors.grey[200],
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 0, 0),
                                  child: Text(
                                    musics![index].artistName,
                                    style: TextStyle(
                                        color: Colors.grey[400], fontSize: 10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
            ),
          ),
          Text('Albüms'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Align(
                          alignment: const AlignmentDirectional(0, 0),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: Image.network(
                                  albums![index].image ??
                                      'https://picsum.photos/seed/387/600',
                                  width: 300,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Align(
                                  alignment: const AlignmentDirectional(0, -1),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(0, 0),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 30, 0, 0),
                                          child: Text(
                                            albums![index].name,
                                            style: TextStyle(
                                                color: Colors.grey[200],
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        albums![index]
                                            .releaseDate
                                            .day
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.grey[400],
                                            fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                  itemCount: albums!.length),
            ),
          ),
          const MobileVideoPlayer(),
        ],
      ),
    );
  }
}

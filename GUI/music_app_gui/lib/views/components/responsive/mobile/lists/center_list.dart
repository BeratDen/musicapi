import 'package:flutter/material.dart';
import 'package:music_app_gui/views/components/responsive/mobile/lists/music_list_view_model.dart';
import 'package:provider/provider.dart';

class CenterList extends StatelessWidget {
  const CenterList({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MusicListViewModel>(context);
    // viewModel.fetchMusicList();
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: FutureBuilder(
            future: viewModel.fetchMusicList(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (cotnext, index) => (Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        snapshot.data![index].image,
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.sizeOf(context).height * 1,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  scrollDirection: Axis.vertical,
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:music_app_gui/views/components/responsive/mobile/singer/singer_list_view_model.dart';
import 'package:provider/provider.dart';

class SingerListView extends StatelessWidget {
  const SingerListView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SingerListViewModel>(context);
    // var data = viewModel.fetchSingers;
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
      child: SizedBox(
        width: double.infinity,
        height: 120,
        child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
            child: FutureBuilder(
                future: viewModel.fetchSingers(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 8),
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(5),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          viewModel.detail(context, snapshot.data![index]);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(64),
                          child: Image.network(
                            snapshot.data![index].avatar!,
                            height: 100, // Burada yüksekliği sınırlıyoruz
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                })),
      ),
    );
  }
}

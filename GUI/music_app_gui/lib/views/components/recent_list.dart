import 'package:flutter/material.dart';
import 'package:music_app_gui/utils/request.dart';
import 'package:music_app_gui/views/components/vertical_card.dart';

class RecentListenedLists extends StatefulWidget {
  const RecentListenedLists({
    super.key,
  });

  @override
  State<RecentListenedLists> createState() => _RecentListenedListsState();
}

class _RecentListenedListsState extends State<RecentListenedLists> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: Request.getLists(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.count(
              crossAxisCount: 2,
              childAspectRatio: (1 / .15),
              shrinkWrap: false,
              children: List.generate(snapshot.data!.length, (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: VerticalCard(
                    list: snapshot.data![index],
                    imagePath: snapshot.data![index].image,
                    text: snapshot.data![index].name,
                  ),
                );
              }),
            );
          } else {
            return const Text('Loading...');
          }
        },
      ),
    );
  }
}

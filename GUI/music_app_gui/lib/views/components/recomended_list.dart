import 'package:flutter/material.dart';
import 'package:music_app_gui/utils/request.dart';
import 'package:music_app_gui/views/components/card_view.dart';

class RecomendedLists extends StatefulWidget {
  const RecomendedLists({
    super.key,
  });

  @override
  State<RecomendedLists> createState() => _RecomendedListsState();
}

class _RecomendedListsState extends State<RecomendedLists> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 3,
        child: FutureBuilder(
          future: Request.getLists(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.count(
                crossAxisCount: 5,
                shrinkWrap: false,
                children: List.generate(snapshot.data!.length, (index) {
                  return CardView(
                    list: snapshot.data![index],
                  );
                }),
              );
            }
            return const Text('Loading...');
          },
        ));
  }
}

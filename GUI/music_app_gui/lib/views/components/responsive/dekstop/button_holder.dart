import 'package:flutter/material.dart';
import 'package:music_app_gui/views/components/iconed_button.dart';
import 'package:music_app_gui/utils/list_utils.dart';

class ButtonHolder extends StatelessWidget {
  const ButtonHolder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                IconedButton(
                  text: 'Anasayfa',
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  },
                  icon: Icons.home,
                ),
                IconedButton(
                  text: 'Ara',
                  onPressed: () => ListUtils.openSearch(context),
                  icon: Icons.search,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

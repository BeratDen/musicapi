import 'package:flutter/material.dart';
import 'package:music_app_gui/views/components/primary_button.dart';

class IconedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData icon;

  const IconedButton({
    super.key,
    required this.text,
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PrimaryButton(
          onPressed: onPressed,
          child: Wrap(
            alignment: WrapAlignment.start, // Elemanları sola yasla
            children: [
              ListTile(
                leading: Icon(
                  icon,
                  color: Colors.grey[300],
                ),
                title: Text(
                  text,
                  style: TextStyle(
                      color: Colors.grey[200], fontWeight: FontWeight.bold),
                ),
              )
            ],
          )),
    );
  }
}

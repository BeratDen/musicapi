import 'package:flutter/material.dart';

class VerticalCard extends StatelessWidget {
  final VoidCallback? onPressed;
  final String imagePath;
  final String text;

  VerticalCard({
    super.key,
    this.onPressed,
    required this.imagePath,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.grey[800]!),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.zero,
        ),
        elevation:
            MaterialStateProperty.all<double>(8.0), // Add elevation for shadow
        shadowColor: MaterialStateProperty.all<Color>(Colors.black),
      ), // Shadow color
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            bottomLeft: Radius.circular(8.0),
          ),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5.0),
                bottomLeft: Radius.circular(5.0),
              ),
              child: Image.network(
                imagePath,
                width: 100.0, // Adjust the width as needed
                height: 100.0, // Adjust the height as needed
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

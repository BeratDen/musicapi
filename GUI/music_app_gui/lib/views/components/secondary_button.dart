import 'package:flutter/material.dart';

class SecondaryButton extends StatefulWidget {
  // we need a annonimus function, name for button
  const SecondaryButton(
      {super.key, required this.onPressed, required this.child});

  final VoidCallback? onPressed;
  final Widget child;

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
          padding:
              WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(15)),
          backgroundColor: WidgetStateProperty.all<Color?>(Colors.blue[600]),
          elevation: WidgetStateProperty.resolveWith<double>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) return 10;
              return 5; // default elevation
            },
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(width: 0, color: Colors.blue[600]!)),
          ),
          animationDuration: const Duration(milliseconds: 200)),
      child: widget.child,
    );
  }
}

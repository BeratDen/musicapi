import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  // we need a annonimus function, name for button
  const PrimaryButton(
      {super.key, required this.onPressed, required this.child});

  final VoidCallback? onPressed;
  final Widget child;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
          padding:
              WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(15)),
          backgroundColor: WidgetStateProperty.all<Color?>(Colors.grey[850]),
          shadowColor: WidgetStateProperty.all<Color>(Colors.grey),
          elevation: WidgetStateProperty.resolveWith<double>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) return 10;
              return 5; // default elevation
            },
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(width: 2, color: Colors.grey[600]!)),
          ),
          animationDuration: const Duration(milliseconds: 200)),
      child: widget.child,
    );
  }
}

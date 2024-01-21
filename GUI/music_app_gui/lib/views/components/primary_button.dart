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
              MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(15)),
          backgroundColor: MaterialStateProperty.all<Color?>(Colors.grey[850]),
          shadowColor: MaterialStateProperty.all<Color>(Colors.grey),
          elevation: MaterialStateProperty.resolveWith<double>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) return 10;
              return 5; // default elevation
            },
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(width: 2, color: Colors.grey[600]!)),
          ),
          animationDuration: const Duration(milliseconds: 200)),
      child: widget.child,
    );
  }
}
// <button type="button" class="
// text-gray-900 bg-white border border-gray-300 focus:outline-none hover:bg-gray-100
// focus:ring-4 focus:ring-gray-200 font-medium rounded-lg text-sm px-5 py-2.5 me-2
// mb-2 dark:bg-gray-800 dark:text-white dark:border-gray-600 dark:hover:bg-gray-700
// dark:hover:border-gray-600 dark:focus:ring-gray-700
// ">Light</button>

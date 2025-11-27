import 'package:flutter/material.dart';

class FixtecBtn extends StatelessWidget {
  const FixtecBtn({super.key, required this.onPressed, required this.child, required this.bgColor, required this.textColor});
  final VoidCallback onPressed;
  final Widget child;
  final Color bgColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 49,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        child: child,
      ),
    );
  }
}

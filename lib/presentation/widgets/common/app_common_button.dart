import 'package:flutter/material.dart';

/// Common button component used across the app
/// Accepts text and padding, rest of the styling is consistent
class AppCommonButton extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry padding;
  final VoidCallback onPressed;
  final double fontSize;
  final FontWeight fontWeight;

  const AppCommonButton({
    super.key,
    required this.text,
    required this.padding,
    required this.onPressed,
    required this.fontSize,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 37, 32, 32),
        foregroundColor: Colors.white,
        elevation: 0,
        shape: const StadiumBorder(),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: padding,
      ),
      child: Text(
        text,
        style: TextStyle(fontWeight: fontWeight, fontSize: fontSize),
      ),
    );
  }
}

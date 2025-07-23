import 'package:flutter/material.dart';

class NormalCustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double height;
  final double weight;
  final double fontSize;
  final Color textColor;
  final Color fillColor;
  final bool showIcon;
  final IconData? sufixIcon;

  const NormalCustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height = 30,
    this.weight = 80,
    this.fontSize = 14,
    this.textColor = Colors.white,
    this.fillColor = const Color(0xffFF3951),
    this.showIcon = false,
    this.sufixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: weight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: fillColor, // Make it red like in your design
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text, style: TextStyle(color: textColor, fontSize: fontSize)),
            const SizedBox(width: 8),
            const SizedBox(width: 5),
            Icon(sufixIcon, color: Colors.white),
          ],
        ),
      ),
    );
  }
}

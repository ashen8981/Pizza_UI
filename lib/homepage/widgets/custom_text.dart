import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;

  const CustomText(
      this.text, {
        Key? key,
        this.fontSize,
        this.fontWeight,
        this.color,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize, // Custom font size
        fontWeight: fontWeight, // Custom font weight
        color: color, // Custom text color
      ),
    );
  }
}

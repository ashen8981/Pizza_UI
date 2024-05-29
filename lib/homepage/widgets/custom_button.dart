import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final Color? buttonColor;
  final Color? textColor;
  final double borderRadius; // New property for specifying border radius

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
    this.buttonColor,
    this.textColor,
    this.borderRadius = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(buttonColor),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(color: textColor),
      ),
    );
  }
}

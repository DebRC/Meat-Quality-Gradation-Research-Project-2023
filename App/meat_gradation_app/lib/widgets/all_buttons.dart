import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  final String title;
  final Color fontColor;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const BigButton(
      {Key? key,
      required this.title,
      required this.fontColor,
      required this.backgroundColor,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
          foregroundColor: fontColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          backgroundColor: backgroundColor),
      child: SizedBox(
        height: 50,
        child: Center(
            child: Text(
          title,
          style: const TextStyle(fontSize: 18, fontFamily: 'Brand-Bold'),
        )),
      ),
    );
  }
}

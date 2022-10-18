import 'package:flutter/material.dart';

class DescriptionText extends StatelessWidget {
  const DescriptionText({
    Key? key,
    required this.text,
    this.style = const TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: 18.0,
      height: 1.56,
      color: Colors.white,
    ),
  }) : super(key: key);

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: style,
    );
  }
}

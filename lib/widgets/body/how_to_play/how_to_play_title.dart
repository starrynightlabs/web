import 'package:flutter/material.dart';
import 'package:web/utils/styles.dart';

class HowToPlayTitle extends StatelessWidget {
  const HowToPlayTitle({Key? key, required this.number, required this.title})
      : super(key: key);

  final int number;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$number.',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 40.0,
            height: 1.25,
            color: NyxsColors.mint,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(title, style: getTitleStyle()),
        const SizedBox(height: 8.0),
      ],
    );
  }
}

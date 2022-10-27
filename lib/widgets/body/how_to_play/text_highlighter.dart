import 'package:flutter/material.dart';
import 'package:web/utils/styles.dart';

class TextHighlighter extends StatelessWidget {
  const TextHighlighter({Key? key, required this.width, this.height = 14.0})
      : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'images/text_highlighter.png',
      width: width,
      height: height,
      color: NyxsColors.mint,
      fit: BoxFit.fitHeight,
      filterQuality: FilterQuality.high,
    );
  }
}

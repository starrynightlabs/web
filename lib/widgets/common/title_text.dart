import 'package:flutter/material.dart';
import 'package:web/utils/styles.dart';

class TitleText extends StatelessWidget {
  final String prefix;
  final String suffix;
  final TextStyle textStyle;
  final TextStyle suffixStyle;

  const TitleText({
    Key? key,
    this.prefix = 'What is ',
    required this.suffix,
    this.textStyle = const TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 28.0,
      height: 1.36,
      color: Colors.white,
    ),
    this.suffixStyle = const TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 28.0,
      height: 1.36,
      color: NyxsColors.mint,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: prefix,
        children: [TextSpan(text: suffix, style: suffixStyle)],
      ),
      style: textStyle,
    );
  }
}

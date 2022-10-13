import 'package:flutter/material.dart';

class NyxsColors {
  static const Color mint = Color.fromRGBO(40, 231, 197, 1.0);
  static const Color navy = Color.fromRGBO(4, 7, 36, 1.0);
}

class NyxsTextStyle {
  static const TextStyle descriptionStyleWithOpacity80 = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 18.0,
    height: 1.56,
    color: Color(0XCCFFFFFF),
  );
}

TextStyle getTitleStyle({
  color = Colors.white,
}) {
  return TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 28.0,
    height: 1.36,
    color: color,
  );
}

TextStyle getDescriptionStyle({
  color = Colors.white,
  fontWeight = FontWeight.w300,
}) {
  return TextStyle(
    fontWeight: fontWeight,
    fontSize: 18.0,
    height: 1.56,
    color: color,
  );
}

mixin CommonWidgetMixin {
  Widget getTitleText({
    prefix = 'What is ',
    required suffix,
    textStyle,
    suffixStyle,
  }) {
    // default styles
    textStyle ??= getTitleStyle();
    suffixStyle ??= getTitleStyle(color: NyxsColors.mint);

    return Text.rich(
      TextSpan(
        text: prefix,
        children: [TextSpan(text: suffix, style: suffixStyle)],
      ),
      style: textStyle,
    );
  }

  Widget getDescriptionText(text, {style}) {
    // default style
    style ??= getDescriptionStyle(
      fontWeight: FontWeight.w400,
      color: Colors.white.withOpacity(0.8),
    );

    return Text(
      text,
      textAlign: TextAlign.center,
      style: style,
    );
  }

  Widget getTag(tag) {
    return Container(
      height: 26.0,
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: NyxsColors.mint),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            tag,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14.0,
              color: NyxsColors.mint,
            ),
          ),
        ],
      ),
    );
  }
}

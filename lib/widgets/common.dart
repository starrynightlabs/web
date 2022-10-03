import 'package:flutter/material.dart';

class Part extends StatelessWidget with CommonWidgetMixin {
  final double currentPixels;
  final bool? isAnimated;

  const Part(this.currentPixels, {Key? key, this.isAnimated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }

  Widget animateWidget(
    widget, {
    required position,
    required startingPoint,
    margin = 10,
    reverse = false,
    duration = const Duration(milliseconds: 500),
  }) {
    double begin = reverse ? position - margin : position + margin;
    double end = position;

    return AnimatedPositioned(
      curve: Curves.easeOutQuart,
      duration: duration,
      top: currentPixels <= startingPoint ? begin : end,
      child: AnimatedOpacity(
        opacity: currentPixels <= startingPoint ? 0.0 : 1.0,
        duration: duration,
        child: widget,
      ),
    );
  }
}

mixin CommonWidgetMixin {
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
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14.0,
              // height: 1.57,
              color: NyxsColors.mint,
            ),
          ),
        ],
      ),
    );
  }
}

class NyxsColors {
  static Color get mint => const Color.fromRGBO(40, 231, 197, 1.0);
  static Color get navy => const Color.fromRGBO(4, 7, 36, 1.0);
}

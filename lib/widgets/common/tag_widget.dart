import 'package:flutter/material.dart';
import 'package:web/utils/styles.dart';

class TagWidget extends StatelessWidget {
  final String tag;
  const TagWidget({Key? key, required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Build from tag widget!');

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

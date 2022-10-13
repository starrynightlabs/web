import 'package:flutter/material.dart';
import 'package:web/scroll_notifier.dart';
import 'package:web/utils/styles.dart';

import 'package:web/widgets/common/animated_widget.dart' as my;
import 'package:web/widgets/common/description_text.dart';
import 'package:web/widgets/common/title_text.dart';

const String nyxsDescription = '''
A new web3 sporting platform
connecting fans with their
favorite athletes.''';

class WhatIsNyxs extends StatefulWidget {
  final ScrollNotifier scrollNotifier;
  const WhatIsNyxs({Key? key, required this.scrollNotifier}) : super(key: key);

  static const double titleTop = 120.0;
  static const double descriptionTop = 166.0;

  @override
  State<WhatIsNyxs> createState() => _WhatIsNyxsState();
}

class _WhatIsNyxsState extends State<WhatIsNyxs>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      height: 360.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.8),
            Colors.black.withOpacity(0.0),
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          my.AnimatedWidget(
            scrollNotifier: widget.scrollNotifier,
            position: WhatIsNyxs.titleTop,
            startingPoint: 477.0,
            child: const TitleText(
              suffix: 'NYXS',
            ),
          ),
          my.AnimatedWidget(
            scrollNotifier: widget.scrollNotifier,
            position: WhatIsNyxs.descriptionTop,
            startingPoint: 518.0,
            child: const DescriptionText(
              text: nyxsDescription,
              style: NyxsTextStyle.descriptionStyleWithOpacity80,
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

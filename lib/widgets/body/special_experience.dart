import 'package:flutter/material.dart';
import 'package:web/scroll_notifier.dart';
import 'package:web/widgets/common/tag_widget.dart';
import 'package:web/widgets/common/animated_widget.dart' as my;

class SpecialExperience extends StatefulWidget {
  final ScrollNotifier scrollNotifier;
  const SpecialExperience({super.key, required this.scrollNotifier});

  final double logoTop = 120.0;
  final double titleTop = 214.0;
  final double tagTop = 322.0;
  final double imageTop = 267.0;

  @override
  State<SpecialExperience> createState() => _SpecialExperienceState();
}

class _SpecialExperienceState extends State<SpecialExperience>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox(
      height: 717.0,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          my.AnimatedWidget(
            scrollNotifier: widget.scrollNotifier,
            position: widget.logoTop,
            // TODO: revert to 3447.0
            startingPoint: 3170.0,
            child: Image.asset(
              'images/large_logo.png',
              width: 156.0,
              height: 54.0,
              filterQuality: FilterQuality.high,
            ),
          ),
          my.AnimatedWidget(
            scrollNotifier: widget.scrollNotifier,
            position: widget.imageTop,
            startingPoint: 3718.0,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  child: SizedBox(
                    height: 449.0,
                    width: MediaQuery.of(context).size.width,
                    child: Image(
                      fit: BoxFit.fitHeight,
                      filterQuality: FilterQuality.high,
                      image: Image.asset(
                        'images/special_experience.png',
                      ).image,
                    ),
                  ),
                ),
                Positioned(
                  child: Container(
                    height: 451.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.0),
                          Colors.black.withOpacity(1.0),
                        ],
                        stops: const [0.67, 1.0],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          my.AnimatedWidget(
            scrollNotifier: widget.scrollNotifier,
            position: widget.titleTop,
            startingPoint: 3477.0,
            child: const Text(
              'Make a special experience\nwith your athletes!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24.0,
                height: 1.42,
                color: Colors.white,
              ),
            ),
          ),
          my.AnimatedWidget(
            scrollNotifier: widget.scrollNotifier,
            position: widget.tagTop,
            startingPoint: 3642.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                TagWidget(tag: 'VIDEO'),
                SizedBox(width: 8.0),
                TagWidget(tag: 'MESSAGE'),
                SizedBox(width: 8.0),
                TagWidget(tag: 'NFT')
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

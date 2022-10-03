import 'package:flutter/material.dart';
import 'package:web/widgets/common.dart';

class WhatIsNyxs extends Part {
  static const double titleTop = 120.0;
  static const double descriptionTop = 166.0;

  const WhatIsNyxs(super.currentPixels, {Key? key, super.isAnimated})
      : assert(isAnimated != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    const String nyxsDescription = '''
A new web3 sporting platform
connecting fans with their
favorite athletes.''';
    Widget title = getTitleText(suffix: 'NYXS');
    Widget description = getDescriptionText(
      nyxsDescription,
      style: getDescriptionStyle(
        color: Colors.white.withOpacity(0.8),
      ),
    );

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
          isAnimated!
              ? Positioned(top: titleTop, child: title)
              : animateWidget(
                  title,
                  position: titleTop,
                  startingPoint: 477.0,
                ),
          isAnimated!
              ? Positioned(top: descriptionTop, child: description)
              : animateWidget(
                  description,
                  position: descriptionTop,
                  startingPoint: 518.0,
                ),
        ],
      ),
    );
  }
}

class WhatIsMission extends Part {
  static const double titleTop = 120.0;
  static const double descriptionTop = 166.0;
  static const double titleTwoTop = 402.0;
  static const double descriptionTwoTop = 448.0;
  static const double imageTop = 540.0;

  const WhatIsMission(super.currentPixels, {Key? key, super.isAnimated})
      : assert(isAnimated != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    const String missionDescription = '''
The mission is the next level goal
for the athletes to achieve the dream,
which is an important opportunity
for fans and athletes to join together
and watch players to grow.''';
    const String starDescription = '''
As a utility token, Stars are swapped
from NYXS(Governance token)''';
    Widget title = getTitleText(suffix: 'Mission');
    Widget description = getDescriptionText(missionDescription);
    Widget titleTwo = getTitleText(suffix: 'Star');
    Widget descriptionTwo = getDescriptionText(starDescription);
    Widget image = Image.asset(
      'images/star.png',
      width: 128.0,
      height: 126.0,
      filterQuality: FilterQuality.high,
    );

    return SizedBox(
      height: 702.0,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          isAnimated!
              ? Positioned(
                  top: titleTop,
                  child: title,
                )
              : animateWidget(
                  title,
                  position: titleTop,
                  startingPoint: 2701.0,
                ),
          isAnimated!
              ? Positioned(
                  top: descriptionTop,
                  child: description,
                )
              : animateWidget(
                  description,
                  position: descriptionTop,
                  startingPoint: 2731.0,
                ),
          isAnimated!
              ? Positioned(
                  top: titleTwoTop,
                  child: titleTwo,
                )
              : animateWidget(
                  titleTwo,
                  position: titleTwoTop,
                  startingPoint: 2957.0,
                ),
          isAnimated!
              ? Positioned(
                  top: descriptionTwoTop,
                  child: descriptionTwo,
                )
              : animateWidget(
                  descriptionTwo,
                  position: descriptionTwoTop,
                  startingPoint: 2987.0,
                ),
          isAnimated!
              ? Positioned(top: imageTop, child: image)
              : animateWidget(
                  image,
                  position: imageTop,
                  startingPoint: 3141.0,
                ),
        ],
      ),
    );
  }
}

class HowToPlay extends Part {
  final Map<String, bool> partsShown;

  const HowToPlay(super.currentPixels, this.partsShown, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double titleTop = 30.0;
    Widget title = Text('How to play', style: getTitleStyle());
    return SizedBox(
      height: 1940.0,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
              partsShown['howToPlayTitle']!
                  ? Positioned(top: titleTop, child: title)
                  : animateWidget(
                      title,
                      position: titleTop,
                      startingPoint: 910.0,
                    ),
            ] +
            howToPlayPartOne +
            howToPlayPartTwo +
            howToPlayPartThree,
      ),
    );
  }

  Widget getHowToPlayPartTitle(number, title) {
    return Column(
      children: [
        Text(
          '$number.',
          style: TextStyle(
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

  Widget getTextHighlighter({required width, height = 14.0}) {
    return Image.asset(
      'images/text_highlighter.png',
      width: width,
      height: height,
      color: NyxsColors.mint,
      fit: BoxFit.fitHeight,
      filterQuality: FilterQuality.high,
    );
  }

  List<Widget> get howToPlayPartOne {
    const double titleTop = 208.0;
    const double descriptionTop = 312.0;
    const double imageTop = 444.0;
    const double decorationTop = 409.0;

    bool isPartOneAnimated = partsShown['howToPlayOne']!;

    const String howToPlayDescription = '''
Your own athletes from all over
the world and missions given to
the athletes every season.''';
    Widget title = getHowToPlayPartTitle(1, 'Select');
    Widget description = Stack(
      children: [
        Positioned(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 125.0,
              top: 70.0,
            ),
            child: getTextHighlighter(width: 123.0),
          ),
        ),
        Positioned(
          child: Text(
            howToPlayDescription,
            style: getDescriptionStyle(),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
    Widget image = Image.asset(
      'images/mission_cards.png',
      height: 164.0,
      fit: BoxFit.fitHeight,
      filterQuality: FilterQuality.high,
    );
    Widget decoration = Image.asset(
      'images/decoration_1.png',
      height: 242.0,
      fit: BoxFit.fitHeight,
      filterQuality: FilterQuality.high,
    );
    Widget lineDecoration = Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: Image.asset(
        'images/line_1.png',
        color: NyxsColors.mint,
        height: 477.5,
        fit: BoxFit.fitHeight,
        filterQuality: FilterQuality.high,
      ),
    );

    return [
      Positioned(top: 267.0, child: lineDecoration),
      isPartOneAnimated
          ? Positioned(top: imageTop, child: image)
          : animateWidget(
              image,
              position: imageTop,
              startingPoint: 1134.0,
            ),
      isPartOneAnimated
          ? Positioned(top: decorationTop, child: decoration)
          : animateWidget(
              decoration,
              position: decorationTop,
              startingPoint: 1264.0,
              margin: 30,
              reverse: true,
              duration: const Duration(milliseconds: 1500),
            ),
      isPartOneAnimated
          ? Positioned(top: descriptionTop, child: description)
          : animateWidget(
              description,
              position: descriptionTop,
              startingPoint: 969.0,
            ),
      isPartOneAnimated
          ? Positioned(top: titleTop, child: title)
          : animateWidget(
              title,
              position: titleTop,
              startingPoint: 933.0,
            ),
    ];
  }

  List<Widget> get howToPlayPartTwo {
    const double titleTop = 788.0;
    const double descriptionTop = 892.0;
    const double imageTop = 1024.0;
    const double decorationTop = 976.0;

    bool isPartTwoAnimated = partsShown['howToPlayTwo']!;

    const String howToPlayDescription = '''
Your athletes with our ‘stars’ and
participate in your athletes
journey together.''';
    Widget title = getHowToPlayPartTitle(2, 'Support');
    Widget description = Stack(
      children: [
        Positioned(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 185.0,
              top: 14.0,
            ),
            child: getTextHighlighter(width: 51.0),
          ),
        ),
        Positioned(
          child: Text(
            howToPlayDescription,
            style: getDescriptionStyle(),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
    Widget image = Padding(
      padding: const EdgeInsets.only(left: 33.0),
      child: Image.asset(
        'images/player_cards.png',
        height: 137.0,
        fit: BoxFit.fitHeight,
        filterQuality: FilterQuality.high,
      ),
    );
    Widget decoration = Padding(
      padding: const EdgeInsets.only(left: 138.0),
      child: Image.asset(
        'images/decoration_2.png',
        width: 152.0,
        height: 246.0,
        fit: BoxFit.fill,
        filterQuality: FilterQuality.high,
      ),
    );
    Widget lineDecoration = Padding(
      padding: const EdgeInsets.only(right: 4.0),
      child: Image.asset(
        'images/line_2.png',
        color: NyxsColors.mint,
        height: 484.1,
        fit: BoxFit.fitHeight,
        filterQuality: FilterQuality.high,
      ),
    );

    return [
      Positioned(top: 822.0, child: lineDecoration),
      isPartTwoAnimated
          ? Positioned(
              top: imageTop,
              child: Padding(
                padding: const EdgeInsets.only(left: 254.0),
                child: image,
              ),
            )
          : Positioned(
              top: imageTop,
              child: AnimatedSlide(
                offset: currentPixels <= 1713.0
                    ? const Offset(0.5, 0.0)
                    : const Offset(0.2, 0.0),
                curve: Curves.easeOutQuart,
                duration: const Duration(seconds: 2),
                child: AnimatedOpacity(
                  opacity: currentPixels <= 1713.0 ? 0.0 : 1.0,
                  duration: const Duration(seconds: 2),
                  child: image,
                ),
              ),
            ),
      isPartTwoAnimated
          ? Positioned(top: decorationTop, child: decoration)
          : animateWidget(
              decoration,
              position: decorationTop,
              startingPoint: 1763.0 + 80,
              reverse: true,
            ),
      isPartTwoAnimated
          ? Positioned(top: descriptionTop, child: description)
          : animateWidget(
              description,
              position: descriptionTop,
              startingPoint: 1550.0,
            ),
      isPartTwoAnimated
          ? Positioned(top: titleTop, child: title)
          : animateWidget(
              title,
              position: titleTop,
              startingPoint: 1504.0,
            ),
    ];
  }

  List<Widget> get howToPlayPartThree {
    const double titleTop = 1341.0;
    const double descriptionTop = 1445.0;
    const double imageTop = 1577.0;
    const double decorationTop = 1513.0;

    bool isPartThreeAnimated = partsShown['howToPlayThree']!;

    const String howToPlayDescription = '''
Together when your athletes
complete the missions and
earn the rewards from NYXS.''';
    Widget title = getHowToPlayPartTitle(3, 'Celebrate');
    Widget description = Stack(
      children: [
        Positioned(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 73.0,
              top: 70.0,
            ),
            child: getTextHighlighter(width: 173.0),
          ),
        ),
        Positioned(
          child: Text(
            howToPlayDescription,
            style: getDescriptionStyle(),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
    Widget image = Image.asset(
      'images/mission_complete_card.png',
      height: 130.0,
      fit: BoxFit.fitHeight,
      filterQuality: FilterQuality.high,
    );
    Widget decoration = Image.asset(
      'images/decoration_3.png',
      height: 276.24,
      fit: BoxFit.fitHeight,
      filterQuality: FilterQuality.high,
    );
    Widget lineDecoration = Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Image.asset(
        'images/line_3.png',
        color: NyxsColors.mint,
        height: 431.51,
        fit: BoxFit.fitHeight,
        filterQuality: FilterQuality.high,
      ),
    );

    return [
      Positioned(top: 1405.0, child: lineDecoration),
      isPartThreeAnimated
          ? Positioned(top: imageTop, child: image)
          : animateWidget(
              image,
              position: imageTop,
              startingPoint: 2259.0,
            ),
      isPartThreeAnimated
          ? Positioned(top: descriptionTop, child: description)
          : animateWidget(
              description,
              position: descriptionTop,
              startingPoint: 2133.0,
            ),
      isPartThreeAnimated
          ? Positioned(top: titleTop, child: title)
          : animateWidget(
              title,
              position: titleTop,
              startingPoint: 2097.0,
            ),
      isPartThreeAnimated
          ? Positioned(top: decorationTop, child: decoration)
          : animateWidget(
              decoration,
              position: decorationTop,
              startingPoint: 2389.0,
              margin: 30,
              reverse: true,
              duration: const Duration(milliseconds: 1500),
            ),
    ];
  }
}

class SpecialExperience extends Part {
  static const double logoTop = 120.0;
  static const double titleTop = 214.0;
  static const double tagTop = 322.0;
  static const double imageTop = 267.0;

  const SpecialExperience(super.currentPixels, {Key? key, super.isAnimated})
      : assert(isAnimated != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget logo = Image.asset(
      'images/large_logo.png',
      width: 156.0,
      height: 54.0,
      filterQuality: FilterQuality.high,
    );
    Widget title = const Text(
      'Make a special experience\nwith your athletes!',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 24.0,
        height: 1.42,
        color: Colors.white,
      ),
    );
    Widget tags = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getTag('VIDEO'),
        const SizedBox(width: 8.0),
        getTag('MESSAGE'),
        const SizedBox(width: 8.0),
        getTag('NFT')
      ],
    );
    Widget image = Stack(
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
    );

    return SizedBox(
      height: 717.0,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          isAnimated!
              ? Positioned(top: logoTop, child: logo)
              : animateWidget(
                  logo,
                  position: logoTop,
                  startingPoint: 3447.0,
                ),
          isAnimated!
              ? Positioned(top: imageTop, child: image)
              : animateWidget(
                  image,
                  position: imageTop,
                  startingPoint: 3718.0,
                ),
          isAnimated!
              ? Positioned(top: titleTop, child: title)
              : animateWidget(
                  title,
                  position: titleTop,
                  startingPoint: 3477.0,
                ),
          isAnimated!
              ? Positioned(top: tagTop, child: tags)
              : animateWidget(
                  tags,
                  position: tagTop,
                  startingPoint: 3642.0,
                ),
        ],
      ),
    );
  }
}

class FAQ extends StatefulWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> with CommonWidgetMixin {
  // TODO: Tokenomics should be added
  // question: answer
  final Map<String, dynamic> items = {
    'What is the NYXS?':
        'We integrate sports and blockchain into one, enabling direct relationships between athletes and fans. Starry Night Foundation (Web3) supports young & potential athletes to close the gap and distance between each athlete to their fans. We are a platform (Community) for Athletes to achieve their sporting ambitions, right from an aspiring rookie to being a seasoned professional.',
    'What is the NYXS token?': '''
Governance token NYXS:
NYXS: a "Starry Night Governance Token. "The token holders have a right to participate in significant community decisions by voting and can support the athletes by exchanging them for stars (Mission Token).
Utility token:
Star: As an athlete's support token, it is non-tradable for now. However, the ways to use it on our platform will gradually vary sooner or later.''',
    'Do I need a wallet to swap in NYXS?':
        'Firstly, you will have to purchase our coins on various exchanges globally. We will also have our coins on major local exchanges for ease of purchase in each of your countries. After this purchase, you can send the coins to the wallet on our mobile application.',
  };
  final List<bool> itemVisible = [];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < items.length; i++) {
      itemVisible.add(false);
    }
  }

  void changeVisibility(int id, [bool visible = true]) {
    setState(() {
      itemVisible[id] = visible;
    });
  }

  Widget get divider {
    return const Divider(
      color: Color(0xff838383),
      height: 8.0,
      thickness: 1.0,
      indent: 18.0,
      endIndent: 18.0,
    );
  }

  Widget getQuestion(String question) {
    return Text(
      question,
      style: getDescriptionStyle(
        fontWeight: FontWeight.w700,
        color: const Color(0xffFAFAFA),
      ),
    );
  }

  Widget getAnswer(String answer) {
    return Text(
      answer,
      style: getDescriptionStyle(
        fontWeight: FontWeight.w400,
        color: const Color(0xffCCCCCC),
      ),
    );
  }

  Widget getArrowImage(bool visible) {
    const showIconPath = 'images/arrow_down.png';
    const hideIconPath = 'images/arrow_up.png';

    return Image.asset(
      visible ? hideIconPath : showIconPath,
      width: 30.0,
      height: 30.0,
      filterQuality: FilterQuality.high,
    );
  }

  List<Widget> getFAQItem(int id, String question, String answer) {
    return [
      Container(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 282.0, child: getQuestion(question)),
            const SizedBox(width: 16.0),
            GestureDetector(
              onTap: () => changeVisibility(id, !itemVisible[id]),
              child: getArrowImage(itemVisible[id]),
            ),
          ],
        ),
      ),
      Visibility(
        visible: itemVisible[id],
        child: Container(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: SizedBox(width: 328.0, child: getAnswer(answer)),
        ),
      ),
      SizedBox(width: 360.0, child: divider)
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      const Align(
        alignment: Alignment.center,
        child: Text(
          "FAQ",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 32.0,
            height: 1.31,
            color: Colors.white,
          ),
        ),
      ),
      const SizedBox(height: 56.0),
    ];

    var i = 0;
    for (MapEntry e in items.entries) {
      children += getFAQItem(i, e.key, e.value);
      i++;
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.black,
      padding: const EdgeInsets.only(top: 80.0, bottom: 16.0),
      child: Column(children: children),
    );
  }
}

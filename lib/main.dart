import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:web/utils.dart';
import 'package:flutter_fadein/flutter_fadein.dart';

void main() {
  setPathUrlStrategy();
  runApp(const NyxsWeb());
}

class NyxsWeb extends StatelessWidget {
  const NyxsWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NYXS',
      theme: ThemeData(fontFamily: 'Euclid Circular A'),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late ScrollController _controller;
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 400),
    vsync: this,
  )..forward();
  double pixels = 0.0;

  bool isWeMakeStarsShown = false;
  bool isWhatIsNyxsShown = false;
  bool isHowToPlayTitleShown = false;
  bool isHowToPlayOneShown = false;
  bool isHowToPlayTwoShown = false;
  bool isHowToPlayThreeShown = false;
  bool isWhatIsMissionShown = false;
  bool isSpecialExperienceShown = false;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(() {
      setState(() {
        pixels = _controller.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NyxsColors.navy,
      appBar: AppBar(
        backgroundColor: NyxsColors.navy,
        toolbarHeight: 72.0,
        leadingWidth: 86.0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Image.asset(
            'images/logo.png',
            filterQuality: FilterQuality.high,
          ),
        ),
      ),
      body: SizedBox(
        height: 5144.0,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          controller: _controller,
          child: Column(
            children: [
              weMakeStarsPart,
              whatIsNyxsPart,
              howToPlayPart,
              whatIsMissionPart,
              specialExperiencePart,
              launchingMessage,
              footer,
            ],
          ),
        ),
      ),
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

  Widget getAnimatedWidget({
    required marginTop,
    required widget,
    required startingPoint,
    reverse = false,
  }) {
    return AnimatedPositioned(
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 500),
      top: pixels <= startingPoint
          ? (reverse ? marginTop - 10 : marginTop + 10)
          : marginTop,
      child: AnimatedOpacity(
        opacity: pixels <= startingPoint ? 0.0 : 1.0,
        duration: const Duration(milliseconds: 500),
        child: widget,
      ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tag,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14.0,
              height: 1.57,
              color: NyxsColors.mint,
            ),
          ),
        ],
      ),
    );
  }

  Widget get weMakeStarsPart {
    double titleTop = 72.0;
    double descriptionTop = 126.0;
    double tagTop = 206.0;
    double imageTop = 160.0;

    if (pixels >= 45.0) isWeMakeStarsShown = true;

    Widget title = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getTitleText(
          prefix: 'We Make ',
          suffix: 'Stars!',
          textStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 36.0,
            height: 1.06,
            color: Colors.white,
          ),
          suffixStyle: TextStyle(
            color: NyxsColors.mint,
            shadows: [
              Shadow(
                color: NyxsColors.mint.withOpacity(0.8),
                blurRadius: 20.0,
              ),
            ],
          ),
        ),
      ],
    );
    Widget description = getDescriptionText(
      'Support your athletes\nEnjoy the missions together.',
      style: getDescriptionStyle(
        color: Colors.white.withOpacity(0.8),
      ),
    );
    Widget image = Image.asset(
      'images/we_make_stars.png',
      height: 555.0,
      fit: BoxFit.fitHeight,
      filterQuality: FilterQuality.high,
    );
    var tween = Tween<Offset>(
      begin: const Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    return SizedBox(
      height: 715.0,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          isWeMakeStarsShown
              ? Positioned(top: titleTop, child: title)
              : Positioned(
                  top: titleTop,
                  child: SlideTransition(
                    position: tween,
                    child: title,
                  ),
                ),
          isWeMakeStarsShown
              ? Positioned(top: imageTop, child: image)
              : Positioned(
                  top: imageTop,
                  child: SlideTransition(
                    position: tween,
                    child: image,
                  ),
                ),
          isWeMakeStarsShown
              ? Positioned(top: descriptionTop, child: description)
              : Positioned(
                  top: descriptionTop,
                  child: SlideTransition(
                    position: tween,
                    child: description,
                  ),
                ),
          isWeMakeStarsShown
              ? Positioned(top: tagTop, child: getTag('BETA'))
              : Positioned(
                  top: tagTop,
                  child: SlideTransition(
                    position: tween,
                    child: getTag('BETA'),
                  ),
                ),
        ],
      ),
    );
  }

  Widget get whatIsNyxsPart {
    double titleTop = 120.0;
    double descriptionTop = 166.0;

    if (pixels >= 545.0) isWhatIsNyxsShown = true;

    const String nyxsDescription = '''
A new web3 sporting platform
connecting fans with their
favorite athletes.''';
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
          isWhatIsNyxsShown
              ? Positioned(top: titleTop, child: getTitleText(suffix: 'NYXS'))
              : getAnimatedWidget(
                  marginTop: titleTop,
                  widget: getTitleText(suffix: 'NYXS'),
                  startingPoint: 477.0,
                ),
          isWhatIsNyxsShown
              ? Positioned(top: descriptionTop, child: description)
              : getAnimatedWidget(
                  marginTop: descriptionTop,
                  widget: description,
                  startingPoint: 518.0,
                ),
        ],
      ),
    );
  }

  Widget get howToPlayPart {
    double titleTop = 30.0;

    if (pixels >= 919.0) isHowToPlayTitleShown = true;

    Widget title = Text('How to play', style: getTitleStyle());

    return SizedBox(
      height: 1940.0,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          isHowToPlayTitleShown
              ? Positioned(top: titleTop, child: title)
              : getAnimatedWidget(
                  marginTop: titleTop,
                  widget: title,
                  startingPoint: 910.0,
                ),
          ...howToPlayPartOne,
          ...howToPlayPartTwo,
          ...howToPlayPartThree,
        ],
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
    double titleTop = 208.0;
    double descriptionTop = 312.0;
    double imageTop = 444.0;
    double decorationTop = 409.0;

    if (pixels >= 1230.0) isHowToPlayOneShown = true;

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
            'Your own athletes from all over\nthe world and missions given to\nthe athletes every season.',
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
    Widget lineDecoration = Image.asset(
      'images/line_1.png',
      color: NyxsColors.mint,
      height: 477.5,
      fit: BoxFit.fitHeight,
      filterQuality: FilterQuality.high,
    );

    return [
      Positioned(top: 266.0, left: 128.0, child: lineDecoration),
      isHowToPlayOneShown
          ? Positioned(top: imageTop, child: image)
          : getAnimatedWidget(
              marginTop: imageTop,
              widget: image,
              startingPoint: 1134.0,
            ),
      isHowToPlayOneShown
          ? Positioned(top: decorationTop, child: decoration)
          : getAnimatedWidget(
              marginTop: decorationTop,
              widget: decoration,
              startingPoint: 1184.0,
              reverse: true,
            ),
      isHowToPlayOneShown
          ? Positioned(top: descriptionTop, child: description)
          : getAnimatedWidget(
              marginTop: descriptionTop,
              widget: description,
              startingPoint: 969.0,
            ),
      isHowToPlayOneShown
          ? Positioned(top: titleTop, child: title)
          : getAnimatedWidget(
              marginTop: titleTop,
              widget: title,
              startingPoint: 933.0,
            ),
    ];
  }

  List<Widget> get howToPlayPartTwo {
    double titleTop = 788.0;
    double descriptionTop = 892.0;
    double imageTop = 1024.0;
    double decorationTop = 976.0;

    if (pixels >= 1800.0) isHowToPlayTwoShown = true;

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
            'Your athletes with our ‘stars’ and\nparticipate in your athletes\njourney together.',
            style: getDescriptionStyle(),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
    Widget image = Image.asset(
      'images/player_cards.png',
      height: 137.0,
      fit: BoxFit.fitHeight,
      alignment: Alignment.topLeft,
      filterQuality: FilterQuality.high,
    );
    Widget decoration = Image.asset(
      'images/decoration_2.png',
      width: 152.0,
      height: 246.0,
      fit: BoxFit.fill,
      filterQuality: FilterQuality.high,
    );
    Widget lineDecoration = Image.asset(
      'images/line_2.png',
      color: NyxsColors.mint,
      height: 484.1,
      fit: BoxFit.fitHeight,
      filterQuality: FilterQuality.high,
    );

    return [
      Positioned(top: 822.0, left: 135, child: lineDecoration),
      isHowToPlayTwoShown
          ? Positioned(top: imageTop, child: image)
          : getAnimatedWidget(
              marginTop: imageTop,
              widget: image,
              startingPoint: 1713.0,
            ),
      isHowToPlayTwoShown
          ? Positioned(top: decorationTop, child: decoration)
          : getAnimatedWidget(
              marginTop: decorationTop,
              widget: decoration,
              startingPoint: 1763.0,
              reverse: true,
            ),
      isHowToPlayTwoShown
          ? Positioned(top: descriptionTop, child: description)
          : getAnimatedWidget(
              marginTop: descriptionTop,
              widget: description,
              startingPoint: 1550.0,
            ),
      isHowToPlayTwoShown
          ? Positioned(top: titleTop, child: title)
          : getAnimatedWidget(
              marginTop: titleTop,
              widget: title,
              startingPoint: 1504.0,
            ),
    ];
  }

  List<Widget> get howToPlayPartThree {
    double titleTop = 1341.0;
    double descriptionTop = 1445.0;
    double imageTop = 1577.0;
    double decorationTop = 1513.0;

    if (pixels >= 2350.0) isHowToPlayThreeShown = true;

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
            'Together when your athletes\ncomplete the missions and\nearn the rewards from NYXS.',
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
    Widget lineDecoration = Image.asset(
      'images/line_3.png',
      color: NyxsColors.mint,
      height: 431.51,
      fit: BoxFit.fitHeight,
      filterQuality: FilterQuality.high,
    );

    return [
      Positioned(top: 1405.0, left: 156.5, child: lineDecoration),
      isHowToPlayThreeShown
          ? Positioned(top: imageTop, child: image)
          : getAnimatedWidget(
              marginTop: imageTop,
              widget: image,
              startingPoint: 2259.0,
            ),
      isHowToPlayThreeShown
          ? Positioned(top: descriptionTop, child: description)
          : getAnimatedWidget(
              marginTop: descriptionTop,
              widget: description,
              startingPoint: 2133.0,
            ),
      isHowToPlayThreeShown
          ? Positioned(top: titleTop, child: title)
          : getAnimatedWidget(
              marginTop: titleTop,
              widget: title,
              startingPoint: 2097.0,
            ),
      isHowToPlayThreeShown
          ? Positioned(top: decorationTop, child: decoration)
          : getAnimatedWidget(
              marginTop: decorationTop,
              widget: decoration,
              startingPoint: 2309.0,
              reverse: true,
            ),
    ];
  }

  Widget get whatIsMissionPart {
    double titleTop = 120.0;
    double descriptionTop = 166.0;
    double titleTwoTop = 402.0;
    double descriptionTwoTop = 448.0;
    double imageTop = 540.0;

    if (pixels >= 3250) isWhatIsMissionShown = true;

    const String missionDescription = '''
The mission is the next level goal
for the athletes to achieve the dream,
which is an important opportunity
for fans and athletes to join together
and watch players to grow.''';
    const String starDescription = '''
As a utility token, Stars are swapped
from NYXS(Governance token)''';
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
          isWhatIsMissionShown
              ? Positioned(
                  top: titleTop,
                  child: getTitleText(suffix: 'Mission'),
                )
              : getAnimatedWidget(
                  marginTop: titleTop,
                  widget: getTitleText(suffix: 'Mission'),
                  startingPoint: 2701.0,
                ),
          isWhatIsMissionShown
              ? Positioned(
                  top: descriptionTop,
                  child: getDescriptionText(missionDescription),
                )
              : getAnimatedWidget(
                  marginTop: descriptionTop,
                  widget: getDescriptionText(missionDescription),
                  startingPoint: 2731.0,
                ),
          isWhatIsMissionShown
              ? Positioned(
                  top: titleTwoTop,
                  child: getTitleText(suffix: 'Star'),
                )
              : getAnimatedWidget(
                  marginTop: titleTwoTop,
                  widget: getTitleText(suffix: 'Star'),
                  startingPoint: 2957.0,
                ),
          isWhatIsMissionShown
              ? Positioned(
                  top: descriptionTwoTop,
                  child: getDescriptionText(starDescription),
                )
              : getAnimatedWidget(
                  marginTop: descriptionTwoTop,
                  widget: getDescriptionText(starDescription),
                  startingPoint: 2987.0,
                ),
          isWhatIsMissionShown
              ? Positioned(top: imageTop, child: image)
              : getAnimatedWidget(
                  marginTop: imageTop,
                  widget: image,
                  startingPoint: 3141.0,
                ),
        ],
      ),
    );
  }

  Widget get specialExperiencePart {
    double logoTop = 120.0;
    double titleTop = 214.0;
    double tagTop = 322.0;
    double imageTop = 267.0;

    if (pixels >= 3770.0) isSpecialExperienceShown = true;

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
          child: Image(
            height: 450.0,
            fit: BoxFit.fitHeight,
            filterQuality: FilterQuality.high,
            image: Image.asset(
              'images/special_experience.png',
            ).image,
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
          isSpecialExperienceShown
              ? Positioned(top: logoTop, child: logo)
              : getAnimatedWidget(
                  marginTop: logoTop,
                  widget: logo,
                  startingPoint: 3447.0,
                ),
          isSpecialExperienceShown
              ? Positioned(top: imageTop, child: image)
              : getAnimatedWidget(
                  marginTop: imageTop,
                  widget: image,
                  startingPoint: 3718.0,
                ),
          isSpecialExperienceShown
              ? Positioned(top: titleTop, child: title)
              : getAnimatedWidget(
                  marginTop: titleTop,
                  widget: title,
                  startingPoint: 3477.0,
                ),
          isSpecialExperienceShown
              ? Positioned(top: tagTop, child: tags)
              : getAnimatedWidget(
                  marginTop: tagTop,
                  widget: tags,
                  startingPoint: 3642.0,
                ),
        ],
      ),
    );
  }

  Widget get launchingMessage {
    return Container(
      width: double.infinity,
      color: Colors.black,
      padding: const EdgeInsets.only(top: 96.0, bottom: 64.0),
      child: Text(
        'Launching soon.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 32.0,
          height: 1.31,
          color: NyxsColors.mint,
          shadows: [
            BoxShadow(
              color: NyxsColors.mint.withOpacity(0.8),
              blurRadius: 20.0,
            )
          ],
        ),
      ),
    );
  }

  Widget getSocialMediaButton(imagePath, {String? targetUrl}) {
    return SizedBox(
      height: 48.0,
      width: 48.0,
      child: IconButton(
        padding: const EdgeInsets.all(0.0),
        icon: Image.asset(imagePath),
        onPressed: () async {
          if (targetUrl != null) {
            final Uri uri = Uri.parse(targetUrl);
            if (!await launchUrl(uri)) throw 'Could not launch $uri';
          }
        },
      ),
    );
  }

  Widget get socialMediaButtons {
    return Row(
      children: [
        getSocialMediaButton(
          'images/twitter.png',
          // TODO: uncomment when discord, telegram setting done
          // targetUrl: 'https://twitter.com/StarryNightFndn',
        ),
        const SizedBox(width: 10.0),
        getSocialMediaButton('images/telegram.png'),
        const SizedBox(width: 10.0),
        getSocialMediaButton('images/discord.png'),
        const SizedBox(width: 16.0),
        getSocialMediaButton(
          'images/medium.png',
          // TODO: uncomment when discord, telegram setting done
          // targetUrl: 'https://medium.com/@NYXS',
        ),
        const SizedBox(width: 10.0),
        getSocialMediaButton(
          'images/mail.png',
          targetUrl: 'mailto:contact@snlabs.io',
        )
      ],
    );
  }

  Widget get copyright {
    return Text(
      // TODO: create hyperlink to Privacy Policy, Terms Of Use.
      '© 2022 All Rights Reserved. Starry Night Labs Pte. Ltd.\nPrivacy Policy and Terms Of Use.',
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12.0,
        height: 1.83,
        color: Colors.white.withOpacity(0.6),
      ),
    );
  }

  Widget get footer {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.only(left: 16.0, top: 80.0, bottom: 64.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'images/large_logo_white.png',
            width: 127.0,
            height: 43.0,
            filterQuality: FilterQuality.high,
          ),
          const SizedBox(height: 16.0),
          // TODO: create hyperlink to App Store, Play Store.
          Text(
            'Launching soon to\nApple App Store & Google Play Store.',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
              height: 1.62,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 18.0),
          const Divider(
            color: Color(0xff838383),
            height: 24.0,
            thickness: 1.0,
            endIndent: 16.0,
          ),
          const SizedBox(height: 32.0),
          socialMediaButtons,
          const SizedBox(height: 32.0),
          copyright,
        ],
      ),
    );
  }
}

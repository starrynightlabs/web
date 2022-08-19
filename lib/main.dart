import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:web/utils.dart';

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

class _HomePageState extends State<HomePage> {
  late ScrollController _controller;
  double pixels = 0.0;

  bool isWeMakeStarsShown = false;
  bool isWhatIsNyxsShown = false;
  bool isHowToPlayShown = false;
  bool isWhatIsMissionShown = false;
  bool isSpecialExperienceShown = false;

  @override
  void initState() {
    super.initState();

    isWeMakeStarsShown = false;
    isWhatIsNyxsShown = false;
    isHowToPlayShown = false;
    isWhatIsMissionShown = false;
    isSpecialExperienceShown = false;

    _controller = ScrollController();
    _controller.addListener(() {
      setState(() {
        pixels = _controller.position.pixels;
        print(pixels);
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose;
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
      body: SingleChildScrollView(
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

  Widget getAnimatedWidget(
    Widget widget,
    double startingPoint,
  ) {
    return AnimatedContainer(
      alignment: pixels <= startingPoint
          ? const Alignment(0.0, -0.2)
          : const Alignment(0.0, 0.0),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
      child: AnimatedOpacity(
        opacity: pixels <= startingPoint ? 0.0 : 1.0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
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
    double startPoint = 144.0 - 143;
    double descriptionPoint = startPoint + 20;
    double tagPoint = descriptionPoint + 5;
    double imagePoint = tagPoint + 10;

    if (pixels >= (startPoint + 130)) isWeMakeStarsShown = true;

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

    return Column(
      children: [
        const SizedBox(height: 72.0),
        isWeMakeStarsShown ? title : getAnimatedWidget(title, startPoint),
        const SizedBox(height: 20.0),
        Stack(
          children: [
            Positioned(
              child: Align(
                alignment: Alignment.center,
                child: isWeMakeStarsShown
                    ? image
                    : getAnimatedWidget(image, imagePoint),
              ),
            ),
            Positioned(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    isWeMakeStarsShown
                        ? description
                        : getAnimatedWidget(description, descriptionPoint),
                    const SizedBox(height: 26.0),
                    isWeMakeStarsShown
                        ? getTag('BETA')
                        : getAnimatedWidget(getTag('BETA'), tagPoint),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget get whatIsNyxsPart {
    double startPoint = 836.0 - 150;
    double descriptionPoint = startPoint + 41;

    if (pixels >= (startPoint + 61)) isWhatIsNyxsShown = true;

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
      width: double.infinity,
      padding: const EdgeInsets.only(top: 120.0, bottom: 110.0),
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
      child: Column(
        children: [
          isWhatIsNyxsShown
              ? getTitleText(suffix: 'NYXS')
              : getAnimatedWidget(getTitleText(suffix: 'NYXS'), startPoint),
          const SizedBox(height: 8.0),
          isWhatIsNyxsShown
              ? description
              : getAnimatedWidget(description, descriptionPoint),
        ],
      ),
    );
  }

  Widget get howToPlayPart {
    double titlePoint = 1106.0 - 100;

    Widget title = Text('How to play', style: getTitleStyle());

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 30.0, bottom: 119.5),
      child: Column(
        children: [
          isHowToPlayShown ? title : getAnimatedWidget(title, titlePoint),
          howToPlayPartOne,
          const SizedBox(height: 57.5),
          howToPlayPartTwo,
          const SizedBox(height: 65.0),
          howToPlayPartThree,
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

  Widget get howToPlayPartOne {
    double startPoint = 1284.0 - 160;
    double descriptionPoint = startPoint + 36;
    double imagePoint = descriptionPoint + 47;
    double decorationPoint = imagePoint + 35;

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

    return Column(
      children: [
        const SizedBox(height: 140.0),
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(top: 58.0, right: 6.0),
                child: lineDecoration,
              ),
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(top: 236.0),
                child: isHowToPlayShown
                    ? image
                    : getAnimatedWidget(image, imagePoint),
              ),
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(top: 201.0),
                child: isHowToPlayShown
                    ? decoration
                    : getAnimatedWidget(decoration, decorationPoint),
              ),
            ),
            Positioned(
              child: Column(
                children: [
                  isHowToPlayShown
                      ? title
                      : getAnimatedWidget(title, startPoint),
                  isHowToPlayShown
                      ? description
                      : getAnimatedWidget(description, descriptionPoint),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget get howToPlayPartTwo {
    double startPoint = 1864.0 - 140;
    double descriptionPoint = startPoint + 46;
    double imagePoint = descriptionPoint + 47;
    double decorationPoint = imagePoint + 35;

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

    return Column(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: lineDecoration,
              ),
            ),
            Positioned(
              child: Container(
                padding: const EdgeInsets.only(left: 33.0, top: 236.0),
                child: isHowToPlayShown
                    ? image
                    : getAnimatedWidget(image, imagePoint),
              ),
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(left: 168.0, top: 188.0),
                child: isHowToPlayShown
                    ? decoration
                    : getAnimatedWidget(decoration, decorationPoint),
              ),
            ),
            Positioned(
              child: Column(
                children: [
                  isHowToPlayShown
                      ? title
                      : getAnimatedWidget(title, startPoint),
                  isHowToPlayShown
                      ? description
                      : getAnimatedWidget(description, descriptionPoint),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget get howToPlayPartThree {
    double startPoint = 2417.0 - 120;
    double descriptionPoint = startPoint + 36;
    double imagePoint = descriptionPoint + 27;
    double decorationPoint = imagePoint + 35;

    if (pixels >= (startPoint + 120)) isHowToPlayShown = true;

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

    return Column(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0, top: 60.0),
                child: lineDecoration,
              ),
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(top: 236.0),
                child: isHowToPlayShown
                    ? image
                    : getAnimatedWidget(image, imagePoint),
              ),
            ),
            Positioned(
              child: Column(
                children: [
                  isHowToPlayShown
                      ? title
                      : getAnimatedWidget(title, startPoint),
                  isHowToPlayShown
                      ? description
                      : getAnimatedWidget(description, descriptionPoint),
                ],
              ),
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(top: 172.0),
                child: isHowToPlayShown
                    ? decoration
                    : getAnimatedWidget(decoration, decorationPoint),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget get whatIsMissionPart {
    double startPoint = 3135.0 - 100;
    double descriptionOnePoint = startPoint + 30;
    double titleTwoPoint = descriptionOnePoint + 60;
    double descriptionTwoPoint = titleTwoPoint + 30;
    double imagePoint = descriptionTwoPoint + 40;

    if (pixels >= (startPoint + 120)) isWhatIsMissionShown = true;

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

    return Container(
      width: double.infinity,
      color: Colors.black.withOpacity(0.8),
      padding: const EdgeInsets.only(top: 120.0, bottom: 72.0),
      child: Column(
        children: [
          isWhatIsMissionShown
              ? getTitleText(suffix: 'Mission')
              : getAnimatedWidget(getTitleText(suffix: 'Mission'), startPoint),
          const SizedBox(height: 8.0),
          isWhatIsMissionShown
              ? getDescriptionText(missionDescription)
              : getAnimatedWidget(
                  getDescriptionText(missionDescription),
                  descriptionOnePoint,
                ),
          const SizedBox(height: 96.0),
          isWhatIsMissionShown
              ? getTitleText(suffix: 'Star')
              : getAnimatedWidget(getTitleText(suffix: 'Star'), titleTwoPoint),
          const SizedBox(height: 8.0),
          isWhatIsMissionShown
              ? getDescriptionText(starDescription)
              : getAnimatedWidget(
                  getDescriptionText(starDescription),
                  descriptionTwoPoint,
                ),
          isWhatIsMissionShown ? image : getAnimatedWidget(image, imagePoint),
        ],
      ),
    );
  }

  Widget get specialExperiencePart {
    double startPoint = 3837.0 - 100;
    double titlePoint = startPoint + 30;
    double tagPoint = titlePoint + 36;
    double imagePoint = tagPoint + 10;

    if (pixels >= (titlePoint + 120)) isSpecialExperienceShown = true;

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
      alignment: Alignment.center,
      children: [
        Container(
          height: 450.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitHeight,
              filterQuality: FilterQuality.high,
              image: Image.asset(
                'images/special_experience.png',
              ).image,
            ),
          ),
        ),
        Container(
          height: 451.0,
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
      ],
    );

    return Column(
      children: [
        const SizedBox(height: 120.0),
        isSpecialExperienceShown ? logo : getAnimatedWidget(logo, startPoint),
        const SizedBox(height: 40.0),
        Stack(
          children: [
            Positioned(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const SizedBox(height: 50.0),
                    isSpecialExperienceShown
                        ? image
                        : getAnimatedWidget(image, imagePoint),
                  ],
                ),
              ),
            ),
            Positioned(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    isSpecialExperienceShown
                        ? title
                        : getAnimatedWidget(title, titlePoint),
                    const SizedBox(height: 40.0),
                    isSpecialExperienceShown
                        ? tags
                        : getAnimatedWidget(tags, tagPoint),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
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

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:web/utils.dart';
import 'dart:async';

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

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final ScrollController _controller = ScrollController();
  double currentPixels = 0.0;

  Map<String, bool> partsShown = {};
  Map<String, AnimationController> animationControllers = {};

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        currentPixels = _controller.position.pixels;
      });
    });

    for (var part in [
      'whatIsNyxs',
      'howToPlayTitle',
      'howToPlayOne',
      'howToPlayTwo',
      'howToPlayThree',
      'whatIsMission',
      'specialExperience'
    ]) {
      partsShown[part] = false;
    }

    for (var element in ['title', 'description', 'image']) {
      animationControllers[element] = AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      );
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    for (var controller in animationControllers.values) {
      controller.dispose();
    }
    _controller.dispose();
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

  void startWeMakeStarsAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (timer.tick == 1) {
        animationControllers['title']!.forward();
      } else if (timer.tick == 2) {
        animationControllers['description']!.forward();
      } else if (timer.tick == 3) {
        animationControllers['image']!.forward();
      } else {
        timer.cancel();
      }
    });
  }

  Widget animateWeMakeStars(
    widget,
    controller, {
    double beginOffset = 0.4,
  }) {
    return FadeTransition(
      opacity: Tween(begin: 0.0, end: 1.0).animate(controller),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, 0.4),
          end: Offset.zero,
        ).animate(controller),
        child: widget,
      ),
    );
  }

  Widget get weMakeStarsPart {
    double titleTop = 72.0;
    double descriptionTop = 126.0;
    double tagTop = 206.0;
    double imageTop = 160.0;

    AnimationController titleAnimationController =
        animationControllers['title']!;
    AnimationController descriptionAnimationController =
        animationControllers['description']!;
    AnimationController imageAnimationController =
        animationControllers['image']!;
    startWeMakeStarsAnimation();

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

    return SizedBox(
      height: 715.0,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: titleTop,
            child: animateWeMakeStars(title, titleAnimationController),
          ),
          Positioned(
            top: imageTop,
            child: animateWeMakeStars(
              image,
              imageAnimationController,
              beginOffset: 0.1,
            ),
          ),
          Positioned(
            top: descriptionTop,
            child: animateWeMakeStars(
              description,
              descriptionAnimationController,
            ),
          ),
          Positioned(
            top: tagTop,
            child: animateWeMakeStars(
              getTag('BETA'),
              imageAnimationController,
              beginOffset: 0.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget get whatIsNyxsPart {
    double titleTop = 120.0;
    double descriptionTop = 166.0;

    if (currentPixels >= 545.0) partsShown['whatIsNyxs'] = true;
    bool isShown = partsShown['whatIsNyxs']!;

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
          isShown
              ? Positioned(top: titleTop, child: title)
              : animateWidget(
                  title,
                  position: titleTop,
                  startingPoint: 477.0,
                ),
          isShown
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

  Widget get howToPlayPart {
    double titleTop = 30.0;

    if (currentPixels >= 919.0) partsShown['howToPlayTitle'] = true;

    Widget title = Text('How to play', style: getTitleStyle());

    return SizedBox(
      height: 1940.0,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
              partsShown['howToPlayTitle'] == true
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
    double titleTop = 208.0;
    double descriptionTop = 312.0;
    double imageTop = 444.0;
    double decorationTop = 409.0;

    if (currentPixels >= 1500.0) partsShown['howToPlayOne'] = true;
    bool isShown = partsShown['howToPlayOne']!;

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
      isShown
          ? Positioned(top: imageTop, child: image)
          : animateWidget(
              image,
              position: imageTop,
              startingPoint: 1134.0,
            ),
      isShown
          ? Positioned(top: decorationTop, child: decoration)
          : animateWidget(
              decoration,
              position: decorationTop,
              startingPoint: 1264.0,
              margin: 30,
              reverse: true,
              duration: const Duration(milliseconds: 1500),
            ),
      isShown
          ? Positioned(top: descriptionTop, child: description)
          : animateWidget(
              description,
              position: descriptionTop,
              startingPoint: 969.0,
            ),
      isShown
          ? Positioned(top: titleTop, child: title)
          : animateWidget(
              title,
              position: titleTop,
              startingPoint: 933.0,
            ),
    ];
  }

  List<Widget> get howToPlayPartTwo {
    double titleTop = 788.0;
    double descriptionTop = 892.0;
    double imageTop = 1024.0;
    double decorationTop = 976.0;

    if (currentPixels >= 2100.0) partsShown['howToPlayTwo'] == true;
    bool isShown = partsShown['howToPlayTwo']!;

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
      isShown
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
      isShown
          ? Positioned(top: decorationTop, child: decoration)
          : animateWidget(
              decoration,
              position: decorationTop,
              startingPoint: 1763.0 + 80,
              reverse: true,
            ),
      isShown
          ? Positioned(top: descriptionTop, child: description)
          : animateWidget(
              description,
              position: descriptionTop,
              startingPoint: 1550.0,
            ),
      isShown
          ? Positioned(top: titleTop, child: title)
          : animateWidget(
              title,
              position: titleTop,
              startingPoint: 1504.0,
            ),
    ];
  }

  List<Widget> get howToPlayPartThree {
    double titleTop = 1341.0;
    double descriptionTop = 1445.0;
    double imageTop = 1577.0;
    double decorationTop = 1513.0;

    if (currentPixels >= 2700.0) partsShown['howToPlayThree'] = true;
    bool isShown = partsShown['howToPlayThree']!;

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
      isShown
          ? Positioned(top: imageTop, child: image)
          : animateWidget(
              image,
              position: imageTop,
              startingPoint: 2259.0,
            ),
      isShown
          ? Positioned(top: descriptionTop, child: description)
          : animateWidget(
              description,
              position: descriptionTop,
              startingPoint: 2133.0,
            ),
      isShown
          ? Positioned(top: titleTop, child: title)
          : animateWidget(
              title,
              position: titleTop,
              startingPoint: 2097.0,
            ),
      isShown
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

  Widget get whatIsMissionPart {
    double titleTop = 120.0;
    double descriptionTop = 166.0;
    double titleTwoTop = 402.0;
    double descriptionTwoTop = 448.0;
    double imageTop = 540.0;

    if (currentPixels >= 3250.0) partsShown['whatIsMission'] = true;
    bool isShown = partsShown['whatIsMission']!;

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
          isShown
              ? Positioned(
                  top: titleTop,
                  child: title,
                )
              : animateWidget(
                  title,
                  position: titleTop,
                  startingPoint: 2701.0,
                ),
          isShown
              ? Positioned(
                  top: descriptionTop,
                  child: description,
                )
              : animateWidget(
                  description,
                  position: descriptionTop,
                  startingPoint: 2731.0,
                ),
          isShown
              ? Positioned(
                  top: titleTwoTop,
                  child: titleTwo,
                )
              : animateWidget(
                  titleTwo,
                  position: titleTwoTop,
                  startingPoint: 2957.0,
                ),
          isShown
              ? Positioned(
                  top: descriptionTwoTop,
                  child: descriptionTwo,
                )
              : animateWidget(
                  descriptionTwo,
                  position: descriptionTwoTop,
                  startingPoint: 2987.0,
                ),
          isShown
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

  Widget get specialExperiencePart {
    double logoTop = 120.0;
    double titleTop = 214.0;
    double tagTop = 322.0;
    double imageTop = 267.0;

    if (currentPixels >= 3770.0) partsShown['specialExperience'] = true;
    bool isShown = partsShown['specialExperience']!;

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
          isShown
              ? Positioned(top: logoTop, child: logo)
              : animateWidget(
                  logo,
                  position: logoTop,
                  startingPoint: 3447.0,
                ),
          isShown
              ? Positioned(top: imageTop, child: image)
              : animateWidget(
                  image,
                  position: imageTop,
                  startingPoint: 3718.0,
                ),
          isShown
              ? Positioned(top: titleTop, child: title)
              : animateWidget(
                  title,
                  position: titleTop,
                  startingPoint: 3477.0,
                ),
          isShown
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

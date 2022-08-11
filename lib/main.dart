import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NYXS / Starry Night Labs',
      theme: ThemeData(fontFamily: 'Euclid Circular A'),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff040724),
      appBar: AppBar(
        backgroundColor: const Color(0xff040724),
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
      body: DefaultTextStyle.merge(
        style: const TextStyle(
          decoration: TextDecoration.none,
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              getWeMakeStarsPart(),
              getWhatIsNyxsPart(),
              getHowToPlayPart(),
              getWhatIsMissionPart(),
              getSpecialExperiencePart(),
              getLaunchingMessage(),
              getFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getWeMakeStarsPart() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 72.0, bottom: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getTitleText(
                prefix: 'We Make ',
                suffix: 'Stars!',
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36.0,
                  height: 1.06,
                ),
                suffixStyle: const TextStyle(
                  color: Color(0xff28E7C5),
                  shadows: [
                    Shadow(
                      color: Color.fromRGBO(40, 231, 197, 0.8),
                      blurRadius: 20.0,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Stack(
          children: [
            Positioned(
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Image.asset(
                    'images/we_make_stars.png',
                    height: 555.0,
                    fit: BoxFit.fitHeight,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
            ),
            Positioned(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    getDescriptionText(
                      'Support your athletes\nEnjoy the missions together.',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 18.0,
                        height: 1.56,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 26.0),
                    getTag('BETA'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget getWhatIsNyxsPart() {
    const String description = '''
A new web3 sporting platform
connecting fans with their
favorite athletes.''';
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
          getTitleText(suffix: 'NYXS'),
          const SizedBox(height: 8.0),
          getDescriptionText(
            description,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 18.0,
              height: 1.56,
              color: Colors.white.withOpacity(0.8),
            ),
          )
        ],
      ),
    );
  }

  Widget getHowToPlayPart() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 30.0, bottom: 119.5),
      child: Column(
        children: [
          getHowToPlayPartOne(),
          const SizedBox(height: 57.5),
          getHowToPlayPartTwo(),
          const SizedBox(height: 65.0),
          getHowToPlayPartThree(),
        ],
      ),
    );
  }

  Widget getHowToPlayPartOne() {
    return Column(
      children: [
        const Text(
          'How to play',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 28.0,
            height: 1.36,
          ),
        ),
        const SizedBox(height: 140.0),
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(top: 58.0, right: 6.0),
                child: Image.asset(
                  'images/line_1.png',
                  color: const Color(0xff28E7C5),
                  height: 477.5,
                  fit: BoxFit.fitHeight,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(top: 236.0),
                child: Image.asset(
                  'images/mission_cards.png',
                  height: 164.0,
                  fit: BoxFit.fitHeight,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(top: 201.0),
                child: Image.asset(
                  'images/decoration_1.png',
                  height: 242.0,
                  fit: BoxFit.fitHeight,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
            Positioned(
              child: Column(
                children: [
                  getHowToPlayPartTitle('1.', 'Select'),
                  Stack(
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
                      const Positioned(
                        child: Text(
                          'Your own athletes from all over\nthe world and missions given to\nthe athletes every season.',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18.0,
                            height: 1.56,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget getHowToPlayPartTwo() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Image.asset(
                  'images/line_2.png',
                  color: const Color(0xff28E7C5),
                  height: 484.1,
                  fit: BoxFit.fitHeight,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
            Positioned(
              child: Container(
                padding: const EdgeInsets.only(left: 33.0, top: 236.0),
                child: Image.asset(
                  'images/player_cards.png',
                  height: 137.0,
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.topLeft,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(left: 168.0, top: 188.0),
                child: Image.asset(
                  'images/decoration_2.png',
                  width: 152.0,
                  height: 246.0,
                  fit: BoxFit.fill,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
            Positioned(
              child: Column(
                children: [
                  getHowToPlayPartTitle('2.', 'Support'),
                  Stack(
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
                      const Positioned(
                        child: Text(
                          'Your athletes with our ‘stars’ and\nparticipate in your athletes\njourney together.',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18.0,
                            height: 1.56,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget getHowToPlayPartThree() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0, top: 60.0),
                child: Image.asset(
                  'images/line_3.png',
                  color: const Color(0xff28E7C5),
                  height: 431.51,
                  fit: BoxFit.fitHeight,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(top: 236.0),
                child: Image.asset(
                  'images/mission_complete_card.png',
                  height: 130.0,
                  fit: BoxFit.fitHeight,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
            Positioned(
              child: Column(
                children: [
                  getHowToPlayPartTitle('3.', 'Celebrate'),
                  Stack(
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
                      const Positioned(
                        child: Text(
                          'Together when your athletes\ncomplete the missions and\nearn the rewards from NYXS.',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18.0,
                            height: 1.56,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(top: 172.0),
                child: Image.asset(
                  'images/decoration_3.png',
                  height: 276.24,
                  fit: BoxFit.fitHeight,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget getHowToPlayPartTitle(number, title) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 40.0,
            height: 1.25,
            color: Color(0xff28E7C5),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 28.0,
            height: 1.36,
          ),
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }

  Widget getTextHighlighter({required width, height = 14.0}) {
    return Image.asset(
      'images/text_highlighter.png',
      width: width,
      height: height,
      color: const Color(0xff28E7C5),
      fit: BoxFit.fitHeight,
      filterQuality: FilterQuality.high,
    );
  }

  Widget getTitleText({
    prefix = 'What is ',
    required suffix,
    textStyle,
    suffixStyle,
  }) {
    // default styles
    textStyle ??= const TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 28.0,
      height: 1.36,
    );
    suffixStyle ??= const TextStyle(color: Color(0xff28E7C5));

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
    style ??= TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 18.0,
      height: 1.56,
      color: Colors.white.withOpacity(0.8),
    );

    return Text(
      text,
      textAlign: TextAlign.center,
      style: style,
    );
  }

  Widget getWhatIsMissionPart() {
    const String missionDescription = '''
The mission is the next level goal
for the athletes to achieve the dream,
which is an important opportunity
for fans and athletes to join together
and watch players to grow.''';
    const String starDescription = '''
As a utility token, Stars are swapped
from NYXS(Governance token)''';

    return Container(
      width: double.infinity,
      color: Colors.black.withOpacity(0.8),
      padding: const EdgeInsets.only(top: 120.0, bottom: 72.0),
      child: Column(
        children: [
          getTitleText(suffix: 'Mission'),
          const SizedBox(height: 8.0),
          getDescriptionText(missionDescription),
          const SizedBox(height: 96.0),
          getTitleText(suffix: 'Star'),
          const SizedBox(height: 8.0),
          getDescriptionText(starDescription),
          Image.asset(
            'images/star.png',
            width: 128.0,
            height: 126.0,
            filterQuality: FilterQuality.high,
          ),
        ],
      ),
    );
  }

  Widget getSpecialExperiencePart() {
    return Column(
      children: [
        const SizedBox(height: 120.0),
        Image.asset(
          'images/large_logo.png',
          width: 156.0,
          height: 54.0,
          filterQuality: FilterQuality.high,
        ),
        const SizedBox(height: 40.0),
        Stack(
          children: [
            Positioned(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const SizedBox(height: 50.0),
                    Stack(
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
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const Text(
                      'Make a special experience\nwith your athletes!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24.0,
                        height: 1.42,
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        getTag('VIDEO'),
                        const SizedBox(width: 8.0),
                        getTag('MESSAGE'),
                        const SizedBox(width: 8.0),
                        getTag('NFT')
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget getLaunchingMessage() {
    return Container(
      width: double.infinity,
      color: Colors.black,
      padding: const EdgeInsets.only(top: 96.0, bottom: 64.0),
      child: const Text(
        'Launching soon.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 32.0,
          height: 1.31,
          color: Color(0xff28E7C5),
          shadows: [
            BoxShadow(
              color: Color.fromRGBO(40, 231, 197, 0.8),
              blurRadius: 20.0,
            )
          ],
        ),
      ),
    );
  }

  Widget getFooter() {
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
          const Text(
            'Launching soon to\nApple App Store & Google Play Store.',
            style: TextStyle(height: 1.62),
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

  Widget getTag(tag) {
    return Container(
      height: 26.0,
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: const Color(0xff28E7C5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            tag,
            style: const TextStyle(
              fontSize: 14.0,
              color: Color(0xff28E7C5),
            ),
          ),
        ],
      ),
    );
  }

  Widget get contactEmail {
    return Linkify(
      text: "contact@snlabs.io",
      textScaleFactor: 1.2,
      linkStyle: const TextStyle(
        decoration: TextDecoration.none,
        fontFamily: '-apple-system',
      ),
      onOpen: (link) async {
        final Uri uri = Uri.parse(link.url);
        if (!await launchUrl(uri)) throw 'Could not launch $uri';
      },
    );
  }
}

Widget get socialMediaButtons {
  return Row(
    children: [
      getSocialMediaButton(
        'images/twitter.png',
        targetUrl: 'https://twitter.com/StarryNightFndn',
      ),
      const SizedBox(width: 10.0),
      getSocialMediaButton('images/telegram.png'),
      const SizedBox(width: 10.0),
      getSocialMediaButton('images/discord.png'),
      const SizedBox(width: 16.0),
      getSocialMediaButton(
        'images/medium.png',
        targetUrl: 'https://medium.com/@NYXS',
      ),
      const SizedBox(width: 10.0),
      getSocialMediaButton(
        'images/mail.png',
        targetUrl: 'mailto:contact@snlabs.io',
      )
    ],
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

Widget get copyright {
  return const Text(
    // TODO: create hyperlink to Privacy Policy, Terms Of Use.
    '© 2022 All Rights Reserved. Starry Night Labs Pte. Ltd.\nPrivacy Policy and Terms Of Use.',
    style: TextStyle(fontSize: 12.0, height: 1.83),
  );
}

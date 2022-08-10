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
          color: Color.fromRGBO(255, 255, 255, 1.0),
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              getWeMakeStarsPart(),
              getSpecialExperience(),
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
          padding: const EdgeInsets.fromLTRB(47.0, 72.0, 46.0, 16.0),
          child: DefaultTextStyle.merge(
            style: const TextStyle(
              color: Color(0xffFFFFFF),
              fontWeight: FontWeight.w700,
              fontSize: 36.0,
              height: 1.06,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text.rich(
                  TextSpan(
                    text: 'We Make ',
                    children: [
                      TextSpan(
                        text: 'Stars!',
                        style: TextStyle(color: Color(0xff28E7C5)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Stack(
          children: [
            Positioned(
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                  child: Image.asset(
                    'images/we_make_stars.png',
                    height: 555,
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
                    const Text(
                      'Support your athletes\nEnjoy the missions together.',
                      textAlign: TextAlign.center,
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

  Widget getSpecialExperience() {
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
                    ShaderMask(
                      shaderCallback: (Rect bound) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Color(0xff000000)],
                          stops: [0.7, 1.0],
                        ).createShader(bound);
                      },
                      blendMode: BlendMode.darken,
                      child: Image.asset(
                        'images/special_experience.png',
                        height: 450,
                        fit: BoxFit.fitHeight,
                        filterQuality: FilterQuality.high,
                      ),
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
      color: const Color(0xff000000),
      padding: const EdgeInsets.fromLTRB(55.0, 96.0, 54.0, 64.0),
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
      color: const Color(0xff000000),
      padding: const EdgeInsets.fromLTRB(16.0, 80.0, 0.0, 64.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'images/large_logo_white.png',
            width: 127,
            height: 43,
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
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
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
      getSocialMediaButton('images/medium.png'),
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
    height: 48,
    width: 48,
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

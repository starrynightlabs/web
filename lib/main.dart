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
    return const MaterialApp(
      title: 'NYXS / Starry Night Labs',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff040724),
        toolbarHeight: 72.0,
        leadingWidth: 86.0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child:
              Image.asset('images/logo.png', filterQuality: FilterQuality.high),
        ),
      ),
      body: DefaultTextStyle.merge(
        style: const TextStyle(
          decoration: TextDecoration.none,
          color: Color.fromRGBO(255, 255, 255, 1.0),
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          fontFamily: '-apple-system',
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              getBody(context),
              getFooter(),
            ],
          ),
        ),
      ),
    );
  }

  static Size getLogoContainerSize(Size size) {
    // Logo image size: 3840 x 2160
    var imageSize = const Size(3840, 2160);

    // width of actual logo part in logo image
    var logoWidth = 1440;

    var logicalWidth = size.width * size.aspectRatio / imageSize.aspectRatio;
    var actualWidth = logicalWidth * (imageSize.width / size.width);

    var diffWidth = logoWidth - actualWidth;

    // If diffWidth is positive, logo part is not fully shown
    if (diffWidth > 0) {
      var height = size.height;

      // decrease height to show logo part
      // 0.05 means 5% margin before and after logo part
      height *= 1 - diffWidth / logoWidth - 0.05;

      size = Size(size.width, height);
    }

    return size;
  }

  Widget getBody(context) {
    var size = getLogoContainerSize(MediaQuery.of(context).size);

    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Image.asset('images/bg.png').image,
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              'Launching soon ⚡',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 18.0),
            contactEmail,
            const SizedBox(height: 8.0),
            const SizedBox(height: 18.0),
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
          Image.asset('images/large_logo_white.png', width: 127, height: 43),
          const SizedBox(height: 16.0),
          const Text('Launching soon to\nApple Store & Google Play Store.',
              style: TextStyle(height: 1.62)),
          const SizedBox(height: 18.0),
          const Divider(color: Color(0xff838383), height: 24.0, thickness: 1.0),
          const SizedBox(height: 46.0),
          socialMediaButtons,
          const SizedBox(height: 46.0),
          copyright,
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
      getSocialMediaButton('images/twitter.png'),
      const SizedBox(width: 10.0),
      getSocialMediaButton('images/telegram.png'),
      const SizedBox(width: 10.0),
      getSocialMediaButton('images/discord.png'),
      const SizedBox(width: 16.0),
      getSocialMediaButton('images/medium.png'),
      const SizedBox(width: 10.0),
      getSocialMediaButton('images/mail.png')
    ],
  );
}

Widget getSocialMediaButton(title) {
  return SizedBox(
    height: 48,
    width: 48,
    child: IconButton(
      padding: const EdgeInsets.all(0.0),
      icon: Image.asset(title),
      onPressed: () {},
    ),
  );
}

Widget get copyright {
  return const Text(
      '© 2022 All Rights Reserved. Starry Night Labs Pte. Ltd.\nPrivacy Policy and Terms Of Use.',
      style: TextStyle(fontSize: 12.0, height: 1.83));
}

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
    return DefaultTextStyle.merge(
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
          ],
        ),
      ),
    );
  }

  Size getLogoContainerSize(context) {
    var screenSize = MediaQuery.of(context).size;

    // Logo image size: 3840 x 2160
    var imageSize = const Size(3840, 2160);

    // width of actual logo part in logo image
    var logoWidth = 1440;

    var logicalWidth =
        screenSize.width * screenSize.aspectRatio / imageSize.aspectRatio;
    var actualWidth = logicalWidth * (imageSize.width / screenSize.width);
    var diffWidth = logoWidth - actualWidth;

    if (diffWidth > 0) {
      var height = screenSize.height;

      // decrease height to show logo part
      // 0.05 means 5% margin before and after logo part
      height *= 1 - diffWidth / logoWidth - 0.05;

      screenSize = Size(screenSize.width, height);
    }

    return screenSize;
  }

  Widget getBody(context) {
    var size = getLogoContainerSize(context);

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
            copyright,
            const SizedBox(height: 18.0),
          ],
        ),
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

Widget get copyright {
  return const Text(
    '© 2022 Starry Night Labs Pte. Ltd.',
    style: TextStyle(fontSize: 14),
  );
}

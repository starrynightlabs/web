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

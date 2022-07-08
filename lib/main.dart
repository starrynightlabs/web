import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Starry Night',
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
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            getBody(context),
            const SizedBox(height: 18.0),
            contactEmail,
            const SizedBox(height: 8.0),
            copyright,
            const SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }

  Widget getBody(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 640,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Image.asset('images/bg.jpeg').image,
          fit: BoxFit.cover,
          colorFilter: const ColorFilter.mode(Colors.black26, BlendMode.darken),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Coming soon!',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 18.0),
          Text(
            'We are a leading website and mobile software development company based in Singapore.',
          ),
          SizedBox(height: 6.0),
          Text('The rest of the homepage is coming soon.'),
          SizedBox(height: 6.0),
          Text('Stay tuned!'),
        ],
      ),
    );
  }

  Widget get contactEmail {
    return Linkify(
      text: "contact@starrynightlabs.io",
      textScaleFactor: 1.2,
      linkStyle: const TextStyle(
        decoration: TextDecoration.none,
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
    'Copyright © 2022 Starry Night Labs Pte. Ltd.',
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
  );
}

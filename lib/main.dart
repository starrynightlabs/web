import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'Widgets/intro.dart';
import 'Widgets/body.dart';
import 'Widgets/footer.dart';

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
  static const Map<String, double> partShowMap = {
    'whatIsNyxs': 545.0,
    'howToPlayTitle': 919.0,
    'howToPlayOne': 1500.0,
    'howToPlayTwo': 2100.0,
    'howToPlayThree': 2700.0,
    'whatIsMission': 3250.0,
    'specialExperience': 3770.0,
  };
  final ScrollController _scrollController = ScrollController();
  double currentPixels = 0.0;

  Map<String, bool> partsShown = {};

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        currentPixels = _scrollController.position.pixels;
      });
    });

    for (var part in partShowMap.keys) {
      partsShown[part] = false;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Not to show animation again if once shown
    partShowMap.forEach((key, value) {
      if (currentPixels >= value) partsShown[key] = true;
    });

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
          controller: _scrollController,
          child: Column(
            children: [
              const WeMakeStars(),
              WhatIsNyxs(currentPixels, isAnimated: partsShown['whatIsNyxs']!),
              HowToPlay(currentPixels, partsShown),
              WhatIsMission(
                currentPixels,
                isAnimated: partsShown['whatIsMission']!,
              ),
              SpecialExperience(
                currentPixels,
                isAnimated: partsShown['specialExperience']!,
              ),
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}

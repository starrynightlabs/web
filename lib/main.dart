import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:web/utils.dart';
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
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (currentPixels >= 545.0) partsShown['whatIsNyxs'] = true;
    if (currentPixels >= 919.0) partsShown['howToPlayTitle'] = true;
    if (currentPixels >= 1500.0) partsShown['howToPlayOne'] = true;
    if (currentPixels >= 2100.0) partsShown['howToPlayTwo'] = true;
    if (currentPixels >= 2700.0) partsShown['howToPlayThree'] = true;
    if (currentPixels >= 3250.0) partsShown['whatIsMission'] = true;
    if (currentPixels >= 3770.0) partsShown['specialExperience'] = true;

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
              WhatIsNyxs(partsShown['whatIsNyxs']!, currentPixels),
              HowToPlay(false, currentPixels, partsShown),
              WhatIsMission(partsShown['whatIsMission']!, currentPixels),
              SpecialExperience(
                partsShown['specialExperience']!,
                currentPixels,
              ),
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}

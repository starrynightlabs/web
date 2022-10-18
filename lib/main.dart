import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:web/scroll_notifier.dart';
import 'package:web/utils/styles.dart';
import 'package:web/widgets/body/faq.dart';
import 'package:web/widgets/body/how_to_play.dart';
import 'package:web/widgets/body/special_experience.dart';
import 'package:web/widgets/body/what_is_mission.dart';
import 'package:web/widgets/body/what_is_nyxs.dart';
import 'package:web/widgets/body/we_make_stars.dart';
import 'package:web/widgets/footer.dart';

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
      theme: ThemeData(fontFamily: 'Inter'),
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
  final ScrollNotifier _scrollNotifier = ScrollNotifier();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _scrollNotifier.notifyListeners(_scrollController.position.pixels);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
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
        child: ListView(
          addAutomaticKeepAlives: true,
          controller: _scrollController,
          children: [
            const WeMakeStars(),
            WhatIsNyxs(scrollNotifier: _scrollNotifier),
            HowToPlay(scrollNotifier: _scrollNotifier),
            WhatIsMission(scrollNotifier: _scrollNotifier),
            SpecialExperience(scrollNotifier: _scrollNotifier),
            FAQ(),
            const Footer(),
          ],
        ),
      ),
    );
  }
}

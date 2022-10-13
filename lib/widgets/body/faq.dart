import 'package:flutter/material.dart';
import 'package:web/utils/styles.dart';

class FAQ extends StatefulWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  // TODO: Tokenomics should be added
  // question: answer
  final Map<String, dynamic> items = {
    'What is the NYXS?':
        'We integrate sports and blockchain into one, enabling direct relationships between athletes and fans. Starry Night Foundation (Web3) supports young & potential athletes to close the gap and distance between each athlete to their fans. We are a platform (Community) for Athletes to achieve their sporting ambitions, right from an aspiring rookie to being a seasoned professional.',
    'What is the NYXS token?': '''
Governance token NYXS:
NYXS: a "Starry Night Governance Token. "The token holders have a right to participate in significant community decisions by voting and can support the athletes by exchanging them for stars (Mission Token).
Utility token:
Star: As an athlete's support token, it is non-tradable for now. However, the ways to use it on our platform will gradually vary sooner or later.''',
    'Do I need a wallet to swap in NYXS?':
        'Firstly, you will have to purchase our coins on various exchanges globally. We will also have our coins on major local exchanges for ease of purchase in each of your countries. After this purchase, you can send the coins to the wallet on our mobile application.',
  };
  final List<bool> itemVisible = [];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < items.length; i++) {
      itemVisible.add(false);
    }
  }

  void changeVisibility(int id, [bool visible = true]) {
    setState(() {
      itemVisible[id] = visible;
    });
  }

  Widget get divider {
    return const Divider(
      color: Color(0xff838383),
      height: 8.0,
      thickness: 1.0,
      indent: 18.0,
      endIndent: 18.0,
    );
  }

  Widget getQuestion(String question) {
    return Text(
      question,
      style: getDescriptionStyle(
        fontWeight: FontWeight.w700,
        color: const Color(0xffFAFAFA),
      ),
    );
  }

  Widget getAnswer(String answer) {
    return Text(
      answer,
      style: getDescriptionStyle(
        fontWeight: FontWeight.w400,
        color: const Color(0xffCCCCCC),
      ),
    );
  }

  Widget getArrowImage(bool visible) {
    const showIconPath = 'images/arrow_down.png';
    const hideIconPath = 'images/arrow_up.png';

    return Image.asset(
      visible ? hideIconPath : showIconPath,
      width: 30.0,
      height: 30.0,
      filterQuality: FilterQuality.high,
    );
  }

  List<Widget> getFAQItem(int id, String question, String answer) {
    return [
      Container(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 18.0),
        child: GestureDetector(
          onTap: () => changeVisibility(id, !itemVisible[id]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 282.0, child: getQuestion(question)),
              const SizedBox(width: 16.0),
              getArrowImage(itemVisible[id]),
            ],
          ),
        ),
      ),
      Visibility(
        visible: itemVisible[id],
        child: Container(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: SizedBox(width: 328.0, child: getAnswer(answer)),
        ),
      ),
      SizedBox(width: 360.0, child: divider)
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      const Align(
        alignment: Alignment.center,
        child: Text(
          "FAQ",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 32.0,
            height: 1.31,
            color: Colors.white,
          ),
        ),
      ),
      const SizedBox(height: 56.0),
    ];

    var i = 0;
    for (MapEntry e in items.entries) {
      children += getFAQItem(i, e.key, e.value);
      i++;
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.black,
      padding: const EdgeInsets.only(top: 80.0, bottom: 16.0),
      child: Column(children: children),
    );
  }
}

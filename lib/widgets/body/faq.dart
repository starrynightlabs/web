import 'package:flutter/material.dart';
import 'package:web/utils/styles.dart';

class FAQ extends StatefulWidget {
  FAQ({Key? key}) : super(key: key);

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

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  final List<bool> itemVisible = [];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.items.length; i++) {
      itemVisible.add(false);
    }
  }

  void changeVisibility(int id) {
    setState(() {
      itemVisible[id] = !itemVisible[id];
    });
  }

  @override
  Widget build(BuildContext context) {
    List<FAQItem> fAQItems = [];
    var i = 0;
    for (MapEntry e in widget.items.entries) {
      fAQItems.add(
        FAQItem(
          id: i,
          question: e.key,
          answer: e.value,
          isVisible: itemVisible[i],
          changeVisibility: changeVisibility,
        ),
      );
      i++;
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.black,
      padding: const EdgeInsets.only(top: 80.0, bottom: 16.0),
      child: Column(
        children: [
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
          ...fAQItems,
        ],
      ),
    );
  }
}

class FAQItem extends StatelessWidget {
  const FAQItem({
    super.key,
    required this.id,
    required this.question,
    required this.answer,
    required this.changeVisibility,
    required this.isVisible,
  });

  final int id;
  final bool isVisible;
  final String question;
  final String answer;
  final void Function(int id) changeVisibility;
  final String showIconPath = 'images/arrow_down.png';
  final String hideIconPath = 'images/arrow_up.png';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 18.0),
          child: GestureDetector(
            onTap: () => changeVisibility(id),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 282.0,
                  child: Text(
                    question,
                    style: getDescriptionStyle(
                      fontWeight: FontWeight.w700,
                      color: const Color(0xffFAFAFA),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Image.asset(
                  isVisible ? hideIconPath : showIconPath,
                  width: 30.0,
                  height: 30.0,
                  filterQuality: FilterQuality.high,
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: isVisible,
          child: Container(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: SizedBox(
              width: 328.0,
              child: Text(
                answer,
                style: getDescriptionStyle(
                  fontWeight: FontWeight.w400,
                  color: const Color(0xffCCCCCC),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 360.0,
          child: Divider(
            color: Color(0xff838383),
            height: 8.0,
            thickness: 1.0,
            indent: 18.0,
            endIndent: 18.0,
          ),
        )
      ],
    );
  }
}

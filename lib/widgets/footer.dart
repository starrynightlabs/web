import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:web/utils/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  static void openUrl(String targetUrl) async {
    final Uri uri = Uri.parse(targetUrl);
    if (!await launchUrl(uri)) throw 'Could not launch $uri';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 96.0),
          const LaunchingMessage(),
          const SizedBox(height: 144.0),
          SizedBox(
            width: 360.0,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'images/footer_logo_white.png',
                    width: 70.88,
                    height: 24.0,
                    filterQuality: FilterQuality.high,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    // TODO: create hyperlink to App Store, Play Store.
                    'Launching soon to\nApple App Store & Google Play Store.',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0,
                      height: 1.62,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  const Divider(
                    color: Color(0xff838383),
                    height: 24.0,
                    thickness: 1.0,
                    endIndent: 16.0,
                  ),
                  const SizedBox(height: 32.0),
                  Row(
                    children: const [
                      SocialMediaButton(
                        imagePath: 'images/twitter.png',
                        targetUrl: "https://twitter.com/NYXS_io",
                      ),
                      SizedBox(width: 16.0),
                      SocialMediaButton(
                        imagePath: 'images/telegram.png',
                        targetUrl: "https://t.me/+xNFQU60YKEA0MDY1",
                      ),
                      SizedBox(width: 16.0),
                      SocialMediaButton(
                        imagePath: 'images/discord.png',
                        targetUrl: "https://discord.gg/7rj6r6j5kr",
                      ),
                      SizedBox(width: 16.0),
                      SocialMediaButton(
                        imagePath: 'images/medium.png',
                        targetUrl: 'https://medium.com/@NYXS',
                      ),
                      SizedBox(width: 16.0),
                      SocialMediaButton(
                        imagePath: 'images/instagram.png',
                        targetUrl: 'https://www.instagram.com/nyxs.io/',
                      )
                    ],
                  ),
                  const SizedBox(height: 32.0),
                  const EmailContact(),
                  const SizedBox(height: 32.0),
                  Text(
                    // TODO: create hyperlink to Privacy Policy, Terms Of Use.
                    '© 2022 All Rights Reserved. Starry Night Labs Pte. Ltd.\nPrivacy Policy and Terms Of Use.',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0,
                      height: 1.83,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(height: 64.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SocialMediaButton extends StatelessWidget {
  const SocialMediaButton({super.key, required this.imagePath, this.targetUrl});

  final String imagePath;
  final String? targetUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.0,
      width: 48.0,
      child: IconButton(
        padding: const EdgeInsets.all(0.0),
        icon: Image.asset(imagePath),
        onPressed: () async {
          if (targetUrl != null) Footer.openUrl(targetUrl!);
        },
      ),
    );
  }
}

class LaunchingMessage extends StatelessWidget {
  const LaunchingMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Launching soon.',
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 32.0,
        height: 1.31,
        color: NyxsColors.mint,
        shadows: [
          BoxShadow(
            color: NyxsColors.mint.withOpacity(0.8),
            blurRadius: 20.0,
          )
        ],
      ),
    );
  }
}

class EmailContact extends StatelessWidget {
  const EmailContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Linkify(
      text: "contact@snlabs.io",
      linkStyle: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12.0,
        height: 1.83,
        color: Colors.white,
        decoration: TextDecoration.underline,
      ),
      //  link.url cannot be null
      onOpen: (link) async {
        Footer.openUrl(link.url);
      },
    );
  }
}

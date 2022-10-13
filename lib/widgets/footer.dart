import 'package:flutter/material.dart';
import 'package:web/widgets/common.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget with CommonWidgetMixin {
  const Footer({Key? key}) : super(key: key);

  Widget get launchingMessage {
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

  Widget get logo {
    return Image.asset(
      'images/large_logo_white.png',
      width: 127.0,
      height: 43.0,
      filterQuality: FilterQuality.high,
    );
  }

  Widget get description {
    return Text(
      // TODO: create hyperlink to App Store, Play Store.
      'Launching soon to\nApple App Store & Google Play Store.',
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16.0,
        height: 1.62,
        color: Colors.white.withOpacity(0.6),
      ),
    );
  }

  Widget get divider {
    return const Divider(
      color: Color(0xff838383),
      height: 24.0,
      thickness: 1.0,
      endIndent: 16.0,
    );
  }

  Widget get socialMediaButtons {
    return Row(
      children: [
        getSocialMediaButton(
          'images/twitter.png',
          targetUrl: "https://twitter.com/NYXS_io",
        ),
        const SizedBox(width: 16.0),
        getSocialMediaButton('images/telegram.png'),
        const SizedBox(width: 16.0),
        getSocialMediaButton('images/discord.png'),
        const SizedBox(width: 16.0),
        getSocialMediaButton(
          'images/medium.png',
          // TODO: uncomment when medium is ready
          // targetUrl: 'https://medium.com/@NYXS',
        ),
        const SizedBox(width: 16.0),
        getSocialMediaButton(
          'images/mail.png',
          targetUrl: 'mailto:contact@snlabs.io',
        )
      ],
    );
  }

  Widget get copyright {
    return Text(
      // TODO: create hyperlink to Privacy Policy, Terms Of Use.
      '© 2022 All Rights Reserved. Starry Night Labs Pte. Ltd.\nPrivacy Policy and Terms Of Use.',
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12.0,
        height: 1.83,
        color: Colors.white.withOpacity(0.6),
      ),
    );
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
          launchingMessage,
          const SizedBox(height: 144.0),
          SizedBox(
            width: 360.0,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  logo,
                  const SizedBox(height: 16.0),
                  description,
                  const SizedBox(height: 24.0),
                  divider,
                  const SizedBox(height: 32.0),
                  socialMediaButtons,
                  const SizedBox(height: 32.0),
                  copyright,
                  const SizedBox(height: 64.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getSocialMediaButton(imagePath, {String? targetUrl}) {
    return SizedBox(
      height: 48.0,
      width: 48.0,
      child: IconButton(
        padding: const EdgeInsets.all(0.0),
        icon: Image.asset(imagePath),
        onPressed: () async {
          if (targetUrl != null) {
            final Uri uri = Uri.parse(targetUrl);
            if (!await launchUrl(uri)) throw 'Could not launch $uri';
          }
        },
      ),
    );
  }
}

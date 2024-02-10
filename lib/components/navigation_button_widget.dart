import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationButtonWidget extends StatelessWidget {
  final String url;
  final String image;
  final String? tooltip;
  final double size;
  const NavigationButtonWidget(
      {super.key,
      required this.image,
      required this.url,
      this.tooltip,
      this.size = 50});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Uri uri = Uri.parse(url);
        canLaunchUrl(uri).then(
            (value) => launchUrl(uri, mode: LaunchMode.externalApplication));
      },
      child: Card(
        shape: const CircleBorder(),
        elevation: 1,
        child: CircleAvatar(
          //  backgroundColor: Colors.transparent,
          radius: 40,
          child: CircleAvatar(
            radius: 35,
            backgroundImage: AssetImage(image),
          ),
        ),
      ),
    );
  }
}

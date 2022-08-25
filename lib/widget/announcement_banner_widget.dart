import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class AnnouncementBannerWidget extends StatelessWidget {
  final String content;
  const AnnouncementBannerWidget({Key? key, required this.content})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 54,
      alignment: Alignment.centerLeft,
      color: Colors.white,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Marquee(
          text: content,
          pauseAfterRound: const Duration(seconds: 2),
          blankSpace: 100,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}

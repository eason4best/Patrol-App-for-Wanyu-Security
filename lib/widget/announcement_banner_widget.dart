import 'package:flutter/material.dart';

class AnnouncementBannerWidget extends StatelessWidget {
  final String content;
  const AnnouncementBannerWidget({Key? key, required this.content})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      color: Colors.white,
      child: Text(
        content,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(color: Theme.of(context).primaryColor),
      ),
    );
  }
}

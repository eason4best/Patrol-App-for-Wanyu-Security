import 'package:flutter/material.dart';

class PinnedAnnouncementWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback onPressed;
  const PinnedAnnouncementWidget({
    Key? key,
    required this.title,
    this.subtitle,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(0.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 32 * 2,
        child: ListTile(
          title: Text(title),
          subtitle: subtitle != null ? Text(subtitle!) : null,
          onTap: onPressed,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AnnouncementWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool? read;
  final VoidCallback onPressed;
  const AnnouncementWidget({
    Key? key,
    required this.title,
    this.subtitle,
    this.read,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: read == null
          ? null
          : read == true
              ? null
              : Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                ),
      onTap: onPressed,
    );
  }
}

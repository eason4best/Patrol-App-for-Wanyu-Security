import 'package:flutter/material.dart';

class AnnouncementWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final DateTime announceDateTime;
  final bool? seen;
  const AnnouncementWidget({
    Key? key,
    required this.title,
    this.subtitle,
    required this.announceDateTime,
    this.seen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        '${announceDateTime.month}/${announceDateTime.day}',
        style: Theme.of(context).textTheme.caption,
      ),
      title: Text(title),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          : null,
      trailing: seen == null
          ? null
          : seen == true
              ? null
              : Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                ),
      onTap: subtitle != null
          ? () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text(title),
                    content: Text(subtitle!),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text(
                            '確認',
                            textAlign: TextAlign.end,
                          )),
                    ],
                  ))
          : () {},
    );
  }
}

import 'package:flutter/material.dart';

class LocationRequestBanner extends StatelessWidget {
  final String content;
  const LocationRequestBanner({super.key, required this.content});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      shape: const Border(bottom: BorderSide(color: Colors.black12)),
      leading: const Icon(
        Icons.warning_outlined,
        color: Colors.red,
      ),
      title: Text(
        content,
        style:
            Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.red),
      ),
    );
  }
}

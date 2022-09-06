import 'package:flutter/material.dart';

class NotificationDot extends StatelessWidget {
  final int unreadCount;
  const NotificationDot({Key? key, required this.unreadCount})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return unreadCount != 0
        ? Container(
            width: 16,
            height: 16,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                unreadCount.toString(),
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: Colors.white),
              ),
            ),
          )
        : Container();
  }
}

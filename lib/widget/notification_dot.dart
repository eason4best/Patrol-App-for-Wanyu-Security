import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security_wanyu/model/total_unseen_announcement.dart';

class NotificationDot extends StatelessWidget {
  final int? individualUnseenCount;
  const NotificationDot({
    Key? key,
    this.individualUnseenCount,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (individualUnseenCount != null) {
      return individualUnseenCount != 0
          ? Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  individualUnseenCount.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: Colors.white),
                ),
              ),
            )
          : Container();
    } else {
      return Consumer<TotalUnseenAnnouncement>(
        builder: (context, totalUnseenAnnouncement, _) =>
            totalUnseenAnnouncement.totalUnseenAnnouncements != 0
                ? Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        totalUnseenAnnouncement.totalUnseenAnnouncements
                            .toString(),
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  )
                : Container(),
      );
    }
  }
}

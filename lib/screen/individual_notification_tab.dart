import 'dart:math';

import 'package:flutter/material.dart';
import 'package:security_wanyu/widget/announcement_widget.dart';
import 'package:security_wanyu/widget/pinned_announcement_widget.dart';

class IndividualNotificationTab extends StatefulWidget {
  const IndividualNotificationTab({Key? key}) : super(key: key);

  @override
  State<IndividualNotificationTab> createState() =>
      _IndividualNotificationTabState();
}

class _IndividualNotificationTabState extends State<IndividualNotificationTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: List.generate(
                  10,
                  (index) => Container(
                    margin: EdgeInsets.only(left: index == 0 ? 0 : 16),
                    child: PinnedAnnouncementWidget(
                      title: '置頂通知標題${index + 1}',
                      subtitle: '置頂通知內文預覽${index + 1}',
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            ),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              var tf = [true, false];
              final random = Random();
              return AnnouncementWidget(
                title: '通知標題${index + 1}',
                subtitle: '通知內文預覽${index + 1}',
                read: tf[random.nextInt(tf.length)],
                onPressed: () {},
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:security_wanyu/widget/announcement_widget.dart';

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
    return ListView.builder(
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}

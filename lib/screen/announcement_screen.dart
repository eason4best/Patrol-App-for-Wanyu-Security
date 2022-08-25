import 'package:flutter/material.dart';
import 'package:security_wanyu/enum/announcements.dart';
import 'package:security_wanyu/screen/company_announcement_tab.dart';
import 'package:security_wanyu/screen/individual_notification_tab.dart';
import 'package:security_wanyu/screen/sign_doc_tab.dart';
import 'package:security_wanyu/widget/notification_dot.dart';

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('公告'),
          bottom: TabBar(
            tabs: Announcements.values.map(
              (a) {
                int unreadCount = a == Announcements.companyAnnouncement
                    ? 1
                    : a == Announcements.individualNotification
                        ? 3
                        : 1;
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Tab(text: a.toString()),
                    Positioned(
                      top: 4,
                      right: -8,
                      child: NotificationDot(unreadCount: unreadCount),
                    ),
                  ],
                );
              },
            ).toList(),
            labelColor: Colors.black87,
            unselectedLabelColor: Colors.black54,
            indicatorColor: Colors.black87,
          ),
        ),
        body: const TabBarView(children: [
          CompanyAnnouncementTab(),
          IndividualNotificationTab(),
          SignDocTab(),
        ]),
      ),
    );
  }
}

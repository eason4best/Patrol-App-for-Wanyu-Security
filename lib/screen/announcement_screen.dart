import 'package:flutter/material.dart';
import 'package:security_wanyu/enum/announcements.dart';
import 'package:security_wanyu/screen/company_announcement_tab.dart';
import 'package:security_wanyu/screen/individual_notification_tab.dart';
import 'package:security_wanyu/screen/sign_doc_tab.dart';

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
            tabs: Announcements.values
                .map((a) => Tab(text: a.toString()))
                .toList(),
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

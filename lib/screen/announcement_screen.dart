import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security_wanyu/bloc/announcement_screen_bloc.dart';
import 'package:security_wanyu/enum/announcements.dart';
import 'package:security_wanyu/model/announcement_screen_model.dart';
import 'package:security_wanyu/model/member.dart';
import 'package:security_wanyu/screen/company_announcement_tab.dart';
import 'package:security_wanyu/screen/individual_notification_tab.dart';
import 'package:security_wanyu/screen/sign_doc_tab.dart';
import 'package:security_wanyu/widget/notification_dot.dart';

class AnnouncementScreen extends StatelessWidget {
  final AnnouncementScreenBloc bloc;
  const AnnouncementScreen({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  static Widget create() {
    return Provider<AnnouncementScreenBloc>(
      create: (context) => AnnouncementScreenBloc(
          member: Provider.of<Member>(context, listen: false)),
      child: Consumer<AnnouncementScreenBloc>(
        builder: (context, bloc, _) => AnnouncementScreen(bloc: bloc),
      ),
      dispose: (context, bloc) => bloc.dispose(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: StreamBuilder<AnnouncementScreenModel>(
          stream: bloc.stream,
          initialData: bloc.model,
          builder: (context, snapshot) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('公告'),
                bottom: TabBar(
                  tabs: Announcements.values
                      .map(
                        (a) => Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Tab(text: a.toString()),
                            Positioned(
                              top: 4,
                              right: -8,
                              child: NotificationDot(
                                  unreadCount:
                                      a == Announcements.companyAnnouncement
                                          ? snapshot
                                              .data!
                                              .companyAnnouncementTab!
                                              .unseenAnnouncementsCount
                                          : a ==
                                                  Announcements
                                                      .individualNotification
                                              ? snapshot
                                                  .data!
                                                  .individualNotificationTab!
                                                  .unseenNotificationsCount
                                              : 1),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                  labelColor: Colors.black87,
                  unselectedLabelColor: Colors.black54,
                  indicatorColor: Colors.black87,
                ),
              ),
              body: TabBarView(children: [
                CompanyAnnouncementTab(bloc: bloc),
                IndividualNotificationTab(bloc: bloc),
                const SignDocTab(),
              ]),
            );
          }),
    );
  }
}

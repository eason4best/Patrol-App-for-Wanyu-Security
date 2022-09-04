import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security_wanyu/model/individual_notification.dart';
import 'package:security_wanyu/model/member.dart';
import 'package:security_wanyu/service/etun_api.dart';
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
    return FutureBuilder<List<IndividualNotification>>(
        future: EtunAPI.getIndividualNotifications(
            memberId: Provider.of<Member>(context, listen: false).memberId!),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      snapshot.data!.any((ino) => ino.pinned!)
                          ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: List.generate(
                                    snapshot.data!
                                        .where((ino) => ino.pinned!)
                                        .toList()
                                        .length,
                                    (index) => Container(
                                      margin: EdgeInsets.only(
                                          left: index == 0 ? 0 : 16),
                                      child: PinnedAnnouncementWidget(
                                        title: snapshot.data!
                                            .where((ino) => ino.pinned!)
                                            .toList()[index]
                                            .title!,
                                        subtitle: snapshot.data!
                                            .where((ino) => ino.pinned!)
                                            .toList()[index]
                                            .content,
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return AnnouncementWidget(
                            title: snapshot.data![index].title!,
                            subtitle: snapshot.data![index].content,
                            announceDateTime:
                                snapshot.data![index].notificationDateTime!,
                            seen: snapshot.data![index].seen,
                          );
                        },
                      ),
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  @override
  bool get wantKeepAlive => true;
}

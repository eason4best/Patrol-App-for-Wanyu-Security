import 'dart:math';

import 'package:flutter/material.dart';
import 'package:security_wanyu/model/company_announcement.dart';
import 'package:security_wanyu/service/etun_api.dart';
import 'package:security_wanyu/widget/announcement_widget.dart';
import 'package:security_wanyu/widget/pinned_announcement_widget.dart';

class CompanyAnnouncementTab extends StatefulWidget {
  const CompanyAnnouncementTab({Key? key}) : super(key: key);

  @override
  State<CompanyAnnouncementTab> createState() => _CompanyAnnouncementTabState();
}

class _CompanyAnnouncementTabState extends State<CompanyAnnouncementTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<List<CompanyAnnouncement>>(
        future: EtunAPI.getCompanyAnnouncements(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      snapshot.data!.any((ca) => ca.pinned!)
                          ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: List.generate(
                                    snapshot.data!
                                        .where((ca) => ca.pinned!)
                                        .toList()
                                        .length,
                                    (index) => Container(
                                      margin: EdgeInsets.only(
                                          left: index == 0 ? 0 : 16),
                                      child: PinnedAnnouncementWidget(
                                        title: snapshot.data!
                                            .where((ca) => ca.pinned!)
                                            .toList()[index]
                                            .title!,
                                        subtitle: snapshot.data!
                                            .where((ca) => ca.pinned!)
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
                          var tf = [true, false];
                          final random = Random();
                          return AnnouncementWidget(
                            title: snapshot.data![index].title!,
                            subtitle: snapshot.data![index].content,
                            announceDateTime:
                                snapshot.data![index].announceDateTime!,
                            seen: tf[random.nextInt(tf.length)],
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

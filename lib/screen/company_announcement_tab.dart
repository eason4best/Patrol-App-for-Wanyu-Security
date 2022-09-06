import 'dart:math';

import 'package:flutter/material.dart';
import 'package:security_wanyu/bloc/announcement_screen_bloc.dart';
import 'package:security_wanyu/widget/announcement_widget.dart';
import 'package:security_wanyu/widget/pinned_announcement_widget.dart';

class CompanyAnnouncementTab extends StatefulWidget {
  final AnnouncementScreenBloc bloc;
  const CompanyAnnouncementTab({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  @override
  State<CompanyAnnouncementTab> createState() => _CompanyAnnouncementTabState();
}

class _CompanyAnnouncementTabState extends State<CompanyAnnouncementTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return !widget.bloc.model.isLoadingCompanyAnnouncement!
        ? SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: List.generate(
                        widget.bloc.model.pinnedCompanyAnnouncements.length,
                        (index) => Container(
                          margin: EdgeInsets.only(left: index == 0 ? 0 : 16),
                          child: PinnedAnnouncementWidget(
                            title: widget.bloc.model
                                .pinnedCompanyAnnouncements[index].title!,
                            subtitle: widget.bloc.model
                                .pinnedCompanyAnnouncements[index].content,
                            onTap: () => showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text(widget
                                          .bloc
                                          .model
                                          .pinnedCompanyAnnouncements[index]
                                          .title!),
                                      content: Text(widget
                                          .bloc
                                          .model
                                          .pinnedCompanyAnnouncements[index]
                                          .content!),
                                      actions: [
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: const Text(
                                              '確認',
                                              textAlign: TextAlign.end,
                                            )),
                                      ],
                                    )),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.bloc.model.companyAnnouncements!.length,
                  itemBuilder: (context, index) {
                    var tf = [true, false];
                    final random = Random();
                    return AnnouncementWidget(
                      title:
                          widget.bloc.model.companyAnnouncements![index].title!,
                      subtitle: widget
                          .bloc.model.companyAnnouncements![index].content,
                      announceDateTime: widget.bloc.model
                          .companyAnnouncements![index].announceDateTime!,
                      seen: tf[random.nextInt(tf.length)],
                      onTap: () => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text(widget.bloc.model
                                    .companyAnnouncements![index].title!),
                                content: Text(widget.bloc.model
                                    .companyAnnouncements![index].content!),
                                actions: [
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text(
                                        '確認',
                                        textAlign: TextAlign.end,
                                      )),
                                ],
                              )),
                    );
                  },
                ),
              ],
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }

  @override
  bool get wantKeepAlive => true;
}

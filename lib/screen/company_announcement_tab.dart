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
    if (widget.bloc.model.hasInternetConnection!) {
      if (widget.bloc.model.companyAnnouncementTab!.isLoading!) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.all(widget
                          .bloc
                          .model
                          .companyAnnouncementTab!
                          .pinnedAnnouncements
                          .isNotEmpty
                      ? 16
                      : 0),
                  child: Row(
                    children: List.generate(
                      widget.bloc.model.companyAnnouncementTab!
                          .pinnedAnnouncements.length,
                      (index) => Container(
                        margin: EdgeInsets.only(left: index == 0 ? 0 : 16),
                        child: PinnedAnnouncementWidget(
                          title: widget.bloc.model.companyAnnouncementTab!
                              .pinnedAnnouncements[index].title!,
                          subtitle: widget.bloc.model.companyAnnouncementTab!
                              .pinnedAnnouncements[index].content,
                          onTap: () {
                            widget.bloc.markCompanyAnnouncementAsSeen(
                                companyAnnouncement: widget
                                    .bloc
                                    .model
                                    .companyAnnouncementTab!
                                    .pinnedAnnouncements[index]);
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text(widget
                                          .bloc
                                          .model
                                          .companyAnnouncementTab!
                                          .pinnedAnnouncements[index]
                                          .title!),
                                      content: Text(widget
                                          .bloc
                                          .model
                                          .companyAnnouncementTab!
                                          .pinnedAnnouncements[index]
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
                                    ));
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget
                    .bloc.model.companyAnnouncementTab!.announcements!.length,
                itemBuilder: (context, index) {
                  return AnnouncementWidget(
                    title: widget.bloc.model.companyAnnouncementTab!
                        .announcements![index].title!,
                    subtitle: widget.bloc.model.companyAnnouncementTab!
                        .announcements![index].content,
                    announceDateTime: widget.bloc.model.companyAnnouncementTab!
                        .announcements![index].announceDateTime!,
                    seen: widget
                        .bloc.model.companyAnnouncementTab!.seenAnnouncements!
                        .any((sca) =>
                            sca.announcementId ==
                            widget.bloc.model.companyAnnouncementTab!
                                .announcements![index].announcementId),
                    onTap: () {
                      widget.bloc.markCompanyAnnouncementAsSeen(
                          companyAnnouncement: widget.bloc.model
                              .companyAnnouncementTab!.announcements![index]);
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text(widget
                                    .bloc
                                    .model
                                    .companyAnnouncementTab!
                                    .announcements![index]
                                    .title!),
                                content: Text(widget
                                    .bloc
                                    .model
                                    .companyAnnouncementTab!
                                    .announcements![index]
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
                              ));
                    },
                  );
                },
              ),
            ],
          ),
        );
      }
    } else {
      return const Center(
        child: Text('目前為離線狀態'),
      );
    }
  }

  @override
  bool get wantKeepAlive => true;
}

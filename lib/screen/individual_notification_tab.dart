import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:security_wanyu/bloc/announcement_screen_bloc.dart';
import 'package:security_wanyu/widget/announcement_widget.dart';
import 'package:security_wanyu/widget/pinned_announcement_widget.dart';

class IndividualNotificationTab extends StatefulWidget {
  final AnnouncementScreenBloc bloc;
  const IndividualNotificationTab({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  @override
  State<IndividualNotificationTab> createState() =>
      _IndividualNotificationTabState();
}

class _IndividualNotificationTabState extends State<IndividualNotificationTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return !widget.bloc.model.individualNotificationTab!.isLoading!
        ? Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: List.generate(
                            widget.bloc.model.individualNotificationTab!
                                .pinnedNotifications.length,
                            (index) => Container(
                              margin:
                                  EdgeInsets.only(left: index == 0 ? 0 : 16),
                              child: PinnedAnnouncementWidget(
                                title: widget
                                    .bloc
                                    .model
                                    .individualNotificationTab!
                                    .pinnedNotifications[index]
                                    .title!,
                                subtitle: widget
                                    .bloc
                                    .model
                                    .individualNotificationTab!
                                    .pinnedNotifications[index]
                                    .content,
                                onTap: () {
                                  widget.bloc.markIndividualNotificationAsSeen(
                                      individualNotification: widget
                                          .bloc
                                          .model
                                          .individualNotificationTab!
                                          .pinnedNotifications[index]);
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: Text(widget
                                                .bloc
                                                .model
                                                .individualNotificationTab!
                                                .pinnedNotifications[index]
                                                .title!),
                                            content: Text(widget
                                                .bloc
                                                .model
                                                .individualNotificationTab!
                                                .pinnedNotifications[index]
                                                .content!),
                                            actions: [
                                              TextButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(),
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
                      itemCount: widget.bloc.model.individualNotificationTab!
                          .notifications!.length,
                      itemBuilder: (context, index) {
                        return AnnouncementWidget(
                          title: widget.bloc.model.individualNotificationTab!
                              .notifications![index].title!,
                          subtitle: widget.bloc.model.individualNotificationTab!
                              .notifications![index].content!,
                          announceDateTime: widget
                              .bloc
                              .model
                              .individualNotificationTab!
                              .notifications![index]
                              .notificationDateTime!,
                          seen: widget.bloc.model.individualNotificationTab!
                                  .notifications![index].seen! ||
                              widget.bloc.model.individualNotificationTab!
                                  .seenNotifications!
                                  .any((sn) =>
                                      sn.notificationId ==
                                      widget
                                          .bloc
                                          .model
                                          .individualNotificationTab!
                                          .notifications![index]
                                          .notificationId),
                          onTap: () {
                            widget.bloc.markIndividualNotificationAsSeen(
                                individualNotification: widget
                                    .bloc
                                    .model
                                    .individualNotificationTab!
                                    .notifications![index]);
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text(widget
                                          .bloc
                                          .model
                                          .individualNotificationTab!
                                          .notifications![index]
                                          .title!),
                                      content: Text(widget
                                          .bloc
                                          .model
                                          .individualNotificationTab!
                                          .notifications![index]
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
              ),
              !widget.bloc.model.individualNotificationTab!.isUnlocked!
                  ? ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 4.0,
                          sigmaY: 4.0,
                        ),
                        child: Container(
                            color: Theme.of(context)
                                .scaffoldBackgroundColor
                                .withOpacity(0.3)),
                      ),
                    )
                  : Container(),
              !widget.bloc.model.individualNotificationTab!.isUnlocked!
                  ? Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 32),
                        child: TextField(
                          controller: widget
                              .bloc.individualNotificationPasswordController,
                          textInputAction: TextInputAction.next,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged:
                              widget.bloc.onInputIndividualNotificationPassword,
                          decoration: InputDecoration(
                            hintText: '輸入登入密碼以查看',
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }

  @override
  bool get wantKeepAlive => true;
}

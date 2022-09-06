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
    return !widget.bloc.model.isLoadingIndividualNotification!
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
                            widget.bloc.model.pinnedIndividualNotifications
                                .length,
                            (index) => Container(
                              margin:
                                  EdgeInsets.only(left: index == 0 ? 0 : 16),
                              child: PinnedAnnouncementWidget(
                                title: widget
                                    .bloc
                                    .model
                                    .pinnedIndividualNotifications[index]
                                    .title!,
                                subtitle: widget
                                    .bloc
                                    .model
                                    .pinnedIndividualNotifications[index]
                                    .content,
                                onTap: () {
                                  widget.bloc.markIndividualNotificationAsSeen(
                                      individualNotification: widget.bloc.model
                                              .pinnedIndividualNotifications[
                                          index]);
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: Text(widget
                                                .bloc
                                                .model
                                                .pinnedIndividualNotifications[
                                                    index]
                                                .title!),
                                            content: Text(widget
                                                .bloc
                                                .model
                                                .pinnedIndividualNotifications[
                                                    index]
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
                      itemCount:
                          widget.bloc.model.individualNotifications!.length,
                      itemBuilder: (context, index) {
                        return AnnouncementWidget(
                          title: widget.bloc.model
                              .individualNotifications![index].title!,
                          subtitle: widget.bloc.model
                              .individualNotifications![index].content!,
                          announceDateTime: widget
                              .bloc
                              .model
                              .individualNotifications![index]
                              .notificationDateTime!,
                          seen: widget.bloc.model
                                  .individualNotifications![index].seen! ||
                              widget.bloc.model.seenIndividualNotifications!
                                  .any((sn) =>
                                      sn.notificationId ==
                                      widget
                                          .bloc
                                          .model
                                          .individualNotifications![index]
                                          .notificationId),
                          onTap: () {
                            widget.bloc.markIndividualNotificationAsSeen(
                                individualNotification: widget.bloc.model
                                    .individualNotifications![index]);
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text(widget
                                          .bloc
                                          .model
                                          .individualNotifications![index]
                                          .title!),
                                      content: Text(widget
                                          .bloc
                                          .model
                                          .individualNotifications![index]
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
              !widget.bloc.model.isIndividualNotificationUnlocked!
                  ? ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 4.0,
                          sigmaY: 4.0,
                        ),
                        child: Container(color: Colors.transparent),
                      ),
                    )
                  : Container(),
              !widget.bloc.model.isIndividualNotificationUnlocked!
                  ? Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 32),
                        child: TextField(
                          controller: widget
                              .bloc.individualNotificationPasswordController,
                          textInputAction: TextInputAction.next,
                          obscureText: true,
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.visiblePassword,
                          style: const TextStyle(color: Colors.white),
                          onChanged:
                              widget.bloc.onInputIndividualNotificationPassword,
                          decoration: InputDecoration(
                            hintText: '輸入登入密碼以查看',
                            hintStyle: const TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Colors.black26,
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

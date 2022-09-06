import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security_wanyu/bloc/individual_notification_tab_bloc.dart';
import 'package:security_wanyu/model/individual_notification_tab_model.dart';
import 'package:security_wanyu/model/member.dart';
import 'package:security_wanyu/widget/announcement_widget.dart';
import 'package:security_wanyu/widget/pinned_announcement_widget.dart';

class IndividualNotificationTab extends StatefulWidget {
  final IndividualNotificationTabBloc bloc;
  const IndividualNotificationTab({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  static Widget create({required Member member}) {
    return Provider<IndividualNotificationTabBloc>(
      create: (context) => IndividualNotificationTabBloc(member: member),
      child: Consumer<IndividualNotificationTabBloc>(
        builder: (context, bloc, _) => IndividualNotificationTab(bloc: bloc),
      ),
      dispose: (context, bloc) => bloc.dispose(),
    );
  }

  @override
  State<IndividualNotificationTab> createState() =>
      _IndividualNotificationTabState();
}

class _IndividualNotificationTabState extends State<IndividualNotificationTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<IndividualNotificationTabModel>(
        stream: widget.bloc.stream,
        initialData: widget.bloc.model,
        builder: (context, snapshot) {
          return !snapshot.data!.loading!
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
                                  snapshot.data!.pinnedIndividualNotifications!
                                      .length,
                                  (index) => Container(
                                    margin: EdgeInsets.only(
                                        left: index == 0 ? 0 : 16),
                                    child: PinnedAnnouncementWidget(
                                      title: snapshot
                                          .data!
                                          .pinnedIndividualNotifications![index]
                                          .title!,
                                      subtitle: snapshot
                                          .data!
                                          .pinnedIndividualNotifications![index]
                                          .content,
                                      onPressed: () {},
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
                                snapshot.data!.individualNotifications!.length,
                            itemBuilder: (context, index) {
                              return AnnouncementWidget(
                                title: snapshot.data!
                                    .individualNotifications![index].title!,
                                subtitle: snapshot.data!
                                    .individualNotifications![index].content!,
                                announceDateTime: snapshot
                                    .data!
                                    .individualNotifications![index]
                                    .notificationDateTime!,
                                seen: snapshot
                                    .data!.individualNotifications![index].seen,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    !snapshot.data!.unlocked!
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
                    !snapshot.data!.unlocked!
                        ? Center(
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 32),
                              child: TextField(
                                controller: widget.bloc.passwordController,
                                textInputAction: TextInputAction.next,
                                obscureText: true,
                                cursorColor: Colors.white,
                                keyboardType: TextInputType.visiblePassword,
                                style: const TextStyle(color: Colors.white),
                                onChanged: widget.bloc.onInputPassword,
                                decoration: InputDecoration(
                                  hintText: '輸入登入密碼以查看',
                                  hintStyle:
                                      const TextStyle(color: Colors.white),
                                  filled: true,
                                  fillColor: Colors.black26,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent),
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
        });
  }

  @override
  bool get wantKeepAlive => true;
}

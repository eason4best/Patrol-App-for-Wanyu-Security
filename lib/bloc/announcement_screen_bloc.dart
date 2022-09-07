import 'dart:async';

import 'package:flutter/material.dart';
import 'package:security_wanyu/model/announcement_screen_model.dart';
import 'package:security_wanyu/model/company_announcement.dart';
import 'package:security_wanyu/model/company_announcement_tab_model.dart';
import 'package:security_wanyu/model/individual_notification.dart';
import 'package:security_wanyu/model/individual_notification_tab_model.dart';
import 'package:security_wanyu/model/member.dart';
import 'package:security_wanyu/service/etun_api.dart';

class AnnouncementScreenBloc {
  final Member member;
  AnnouncementScreenBloc({required this.member}) {
    _getCompanyAnnouncements();
    _getIndividualNotifications(memberId: member.memberId!);
  }
  final StreamController<AnnouncementScreenModel> _streamController =
      StreamController();
  Stream<AnnouncementScreenModel> get stream => _streamController.stream;
  AnnouncementScreenModel _model = AnnouncementScreenModel(
    companyAnnouncementTab: CompanyAnnouncementTabModel(
      announcements: [],
      seenAnnouncements: [],
      isLoading: true,
    ),
    individualNotificationTab: IndividualNotificationTabModel(
      notifications: [],
      seenNotifications: [],
      isLoading: true,
      isUnlocked: false,
    ),
  );
  AnnouncementScreenModel get model => _model;
  TextEditingController individualNotificationPasswordController =
      TextEditingController();

  Future<void> _getCompanyAnnouncements() async {
    try {
      List<CompanyAnnouncement> companyAnnouncements =
          await EtunAPI.getCompanyAnnouncements();
      List<int> recentSeenCompanyAnnouncementIds =
          await EtunAPI.getRecentSeenCompanyAnnouncementIds(
              memberId: member.memberId!);
      updateWith(
        companyAnnouncementTab: _model.companyAnnouncementTab!.copyWith(
          announcements: companyAnnouncements,
          seenAnnouncements: companyAnnouncements
              .where((ca) =>
                  recentSeenCompanyAnnouncementIds.contains(ca.announcementId))
              .toList(),
          isLoading: false,
        ),
      );
    } catch (e) {
      emitError(error: e);
    }
  }

  Future<void> _getIndividualNotifications({required int memberId}) async {
    try {
      List<IndividualNotification> individualNotifications =
          await EtunAPI.getIndividualNotifications(memberId: memberId);
      updateWith(
        individualNotificationTab: _model.individualNotificationTab!.copyWith(
          notifications: individualNotifications,
          seenNotifications:
              individualNotifications.where((ino) => ino.seen!).toList(),
          isLoading: false,
        ),
      );
    } catch (e) {
      emitError(error: e);
    }
  }

  void onInputIndividualNotificationPassword(String password) {
    if (password == member.memberPassword) {
      updateWith(
          individualNotificationTab:
              _model.individualNotificationTab!.copyWith(isUnlocked: true));
    }
  }

  Future<void> markIndividualNotificationAsSeen(
      {required IndividualNotification individualNotification}) async {
    List<IndividualNotification>? seenIndividualNotifications =
        _model.individualNotificationTab!.seenNotifications;
    if (!seenIndividualNotifications!.any(
        (sin) => sin.notificationId == individualNotification.notificationId)) {
      seenIndividualNotifications.add(individualNotification);
      updateWith(
          individualNotificationTab: _model.individualNotificationTab!
              .copyWith(seenNotifications: seenIndividualNotifications));
      EtunAPI.markIndividualNotificationAsSeen(
          notificationId: individualNotification.notificationId!);
    }
  }

  Future<void> markCompanyAnnouncementAsSeen(
      {required CompanyAnnouncement companyAnnouncement}) async {
    List<CompanyAnnouncement>? seenCompanyAnnouncements =
        _model.companyAnnouncementTab!.seenAnnouncements;
    if (!seenCompanyAnnouncements!.any(
        (sca) => sca.announcementId == companyAnnouncement.announcementId)) {
      seenCompanyAnnouncements.add(companyAnnouncement);
      updateWith(
          companyAnnouncementTab: _model.companyAnnouncementTab!
              .copyWith(seenAnnouncements: seenCompanyAnnouncements));
      EtunAPI.markCompanyAnnouncementAsSeen(
        announcementId: companyAnnouncement.announcementId!,
        memberId: member.memberId!,
      );
    }
  }

  void updateWith({
    CompanyAnnouncementTabModel? companyAnnouncementTab,
    IndividualNotificationTabModel? individualNotificationTab,
  }) {
    _model = _model.copyWith(
      companyAnnouncementTab: companyAnnouncementTab,
      individualNotificationTab: individualNotificationTab,
    );
    _streamController.add(_model);
  }

  void emitError({required Object error}) {
    _streamController.addError(error);
  }

  void dispose() {
    individualNotificationPasswordController.dispose();
    _streamController.close();
  }
}

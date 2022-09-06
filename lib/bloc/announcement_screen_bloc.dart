import 'dart:async';

import 'package:flutter/material.dart';
import 'package:security_wanyu/model/announcement_screen_model.dart';
import 'package:security_wanyu/model/company_announcement.dart';
import 'package:security_wanyu/model/individual_notification.dart';
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
    companyAnnouncements: [],
    individualNotifications: [],
    isLoadingCompanyAnnouncement: true,
    isLoadingIndividualNotification: true,
    isIndividualNotificationUnlocked: false,
    seenIndividualNotifications: [],
    seenCompanyAnnouncements: [],
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
        companyAnnouncements: companyAnnouncements,
        seenCompanyAnnouncements: companyAnnouncements
            .where((ca) =>
                recentSeenCompanyAnnouncementIds.contains(ca.announcementId))
            .toList(),
        isLoadingCompanyAnnouncement: false,
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
        individualNotifications: individualNotifications,
        seenIndividualNotifications:
            individualNotifications.where((ino) => ino.seen!).toList(),
        isLoadingIndividualNotification: false,
      );
    } catch (e) {
      emitError(error: e);
    }
  }

  void onInputIndividualNotificationPassword(String password) {
    if (password == member.memberPassword) {
      updateWith(isIndividualNotificationUnlocked: true);
    }
  }

  Future<void> markIndividualNotificationAsSeen(
      {required IndividualNotification individualNotification}) async {
    List<IndividualNotification>? seenIndividualNotifications =
        _model.seenIndividualNotifications;
    if (!seenIndividualNotifications!.any(
        (sin) => sin.notificationId == individualNotification.notificationId)) {
      seenIndividualNotifications.add(individualNotification);
      updateWith(seenIndividualNotifications: seenIndividualNotifications);
      EtunAPI.markIndividualNotificationAsSeen(
          notificationId: individualNotification.notificationId!);
    }
  }

  Future<void> markCompanyAnnouncementAsSeen(
      {required CompanyAnnouncement companyAnnouncement}) async {
    List<CompanyAnnouncement>? seenCompanyAnnouncements =
        _model.seenCompanyAnnouncements;
    if (!seenCompanyAnnouncements!.any(
        (sca) => sca.announcementId == companyAnnouncement.announcementId)) {
      seenCompanyAnnouncements.add(companyAnnouncement);
      updateWith(seenCompanyAnnouncements: seenCompanyAnnouncements);
      EtunAPI.markCompanyAnnouncementAsSeen(
        announcementId: companyAnnouncement.announcementId!,
        memberId: member.memberId!,
      );
    }
  }

  void updateWith({
    List<CompanyAnnouncement>? companyAnnouncements,
    List<IndividualNotification>? individualNotifications,
    bool? isLoadingCompanyAnnouncement,
    bool? isLoadingIndividualNotification,
    bool? isIndividualNotificationUnlocked,
    List<IndividualNotification>? seenIndividualNotifications,
    List<CompanyAnnouncement>? seenCompanyAnnouncements,
  }) {
    _model = _model.copyWith(
      companyAnnouncements: companyAnnouncements,
      individualNotifications: individualNotifications,
      isLoadingCompanyAnnouncement: isLoadingCompanyAnnouncement,
      isLoadingIndividualNotification: isLoadingIndividualNotification,
      isIndividualNotificationUnlocked: isIndividualNotificationUnlocked,
      seenIndividualNotifications: seenIndividualNotifications,
      seenCompanyAnnouncements: seenCompanyAnnouncements,
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

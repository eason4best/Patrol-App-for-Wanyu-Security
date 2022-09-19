import 'dart:async';

import 'package:flutter/material.dart';
import 'package:security_wanyu/model/announcement_screen_model.dart';
import 'package:security_wanyu/model/company_announcement.dart';
import 'package:security_wanyu/model/company_announcement_tab_model.dart';
import 'package:security_wanyu/model/individual_notification.dart';
import 'package:security_wanyu/model/individual_notification_tab_model.dart';
import 'package:security_wanyu/model/member.dart';
import 'package:security_wanyu/model/signable_document.dart';
import 'package:security_wanyu/model/signable_document_tab_model.dart';
import 'package:security_wanyu/model/total_unseen_announcement.dart';
import 'package:security_wanyu/other/utils.dart';
import 'package:security_wanyu/service/etun_api.dart';

class AnnouncementScreenBloc {
  final Member member;
  final TotalUnseenAnnouncement totalUnseenAnnouncement;
  AnnouncementScreenBloc({
    required this.member,
    required this.totalUnseenAnnouncement,
  });
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
    signableDocumentTab: SignableDocumentTabModel(
      docs: [],
      signedDocs: [],
      isLoading: true,
    ),
    hasInternetConnection: true,
  );
  AnnouncementScreenModel get model => _model;
  TextEditingController individualNotificationPasswordController =
      TextEditingController();

  Future<void> initialize() async {
    try {
      if (await Utils.hasInternetConnection()) {
        _getCompanyAnnouncements();
        _getIndividualNotifications();
        _getSignableDocuments();
      } else {
        updateWith(hasInternetConnection: false);
      }
    } catch (e) {
      rethrow;
    } finally {
      updateWith(
        companyAnnouncementTab:
            _model.companyAnnouncementTab!.copyWith(isLoading: false),
        individualNotificationTab:
            _model.individualNotificationTab!.copyWith(isLoading: false),
        signableDocumentTab:
            _model.signableDocumentTab!.copyWith(isLoading: false),
      );
    }
  }

  Future<void> _getCompanyAnnouncements() async {
    try {
      List<CompanyAnnouncement> companyAnnouncements =
          await EtunAPI.instance.getCompanyAnnouncements();
      List<int> recentSeenCompanyAnnouncementIds = await EtunAPI.instance
          .getRecentSeenCompanyAnnouncementIds(memberId: member.memberId!);
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
      totalUnseenAnnouncement
          .increase(_model.companyAnnouncementTab!.unseenAnnouncementsCount);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _getIndividualNotifications() async {
    try {
      List<IndividualNotification> individualNotifications = await EtunAPI
          .instance
          .getIndividualNotifications(memberId: member.memberId!);
      updateWith(
        individualNotificationTab: _model.individualNotificationTab!.copyWith(
          notifications: individualNotifications,
          seenNotifications:
              individualNotifications.where((ino) => ino.seen!).toList(),
          isLoading: false,
        ),
      );
      totalUnseenAnnouncement
          .increase(_model.individualNotificationTab!.unseenNotificationsCount);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _getSignableDocuments() async {
    try {
      List<SignableDocument> signDocs =
          await EtunAPI.instance.getSignableDocuments();
      List<int> recentSignedSignableDocumentIds = await EtunAPI.instance
          .getRecentSignedSignableDocumentIds(memberId: member.memberId!);
      updateWith(
        signableDocumentTab: _model.signableDocumentTab!.copyWith(
          docs: signDocs,
          signedDocs: signDocs
              .where((sd) => recentSignedSignableDocumentIds.contains(sd.docId))
              .toList(),
          isLoading: false,
        ),
      );
      totalUnseenAnnouncement
          .increase(_model.signableDocumentTab!.unsignedDocsCount);
    } catch (e) {
      rethrow;
    }
  }

  void onInputIndividualNotificationPassword(String password) {
    if (password == member.memberPassword) {
      updateWith(
          individualNotificationTab:
              _model.individualNotificationTab!.copyWith(isUnlocked: true));
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
      totalUnseenAnnouncement.decrease(1);
      EtunAPI.instance.markCompanyAnnouncementAsSeen(
        announcementId: companyAnnouncement.announcementId!,
        memberId: member.memberId!,
      );
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
      totalUnseenAnnouncement.decrease(1);
      EtunAPI.instance.markIndividualNotificationAsSeen(
          notificationId: individualNotification.notificationId!);
    }
  }

  Future<void> markSignableDocumentAsSigned(
      {required SignableDocument signableDocument}) async {
    List<SignableDocument>? signedSignableDocuments =
        _model.signableDocumentTab!.signedDocs;
    if (!signedSignableDocuments!
        .any((ssd) => ssd.docId == signableDocument.docId)) {
      signedSignableDocuments.add(signableDocument);
      updateWith(
        signableDocumentTab: _model.signableDocumentTab!
            .copyWith(signedDocs: signedSignableDocuments),
      );
      totalUnseenAnnouncement.decrease(1);
      EtunAPI.instance.markSignableDocumentAsSigned(
        docId: signableDocument.docId!,
        memberId: member.memberId!,
      );
    }
  }

  void updateWith({
    CompanyAnnouncementTabModel? companyAnnouncementTab,
    IndividualNotificationTabModel? individualNotificationTab,
    SignableDocumentTabModel? signableDocumentTab,
    bool? hasInternetConnection,
  }) {
    _model = _model.copyWith(
        companyAnnouncementTab: companyAnnouncementTab,
        individualNotificationTab: individualNotificationTab,
        signableDocumentTab: signableDocumentTab,
        hasInternetConnection: hasInternetConnection);
    _streamController.add(_model);
  }

  void dispose() {
    individualNotificationPasswordController.dispose();
    _streamController.close();
  }
}

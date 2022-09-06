import 'package:security_wanyu/model/company_announcement.dart';
import 'package:security_wanyu/model/individual_notification.dart';

class AnnouncementScreenModel {
  final List<CompanyAnnouncement>? companyAnnouncements;
  final List<IndividualNotification>? individualNotifications;
  final bool? isLoadingCompanyAnnouncement;
  final bool? isLoadingIndividualNotification;
  final bool? isIndividualNotificationUnlocked;
  final List<IndividualNotification>? seenIndividualNotifications;
  List<CompanyAnnouncement> get pinnedCompanyAnnouncements =>
      companyAnnouncements!.where((ca) => ca.pinned!).toList();
  List<IndividualNotification> get pinnedIndividualNotifications =>
      individualNotifications!.where((ino) => ino.pinned!).toList();
  int get unseenIndividualNotificationsCount =>
      individualNotifications!.length - seenIndividualNotifications!.length;

  AnnouncementScreenModel({
    this.companyAnnouncements,
    this.individualNotifications,
    this.isLoadingCompanyAnnouncement,
    this.isLoadingIndividualNotification,
    this.isIndividualNotificationUnlocked,
    this.seenIndividualNotifications,
  });

  AnnouncementScreenModel copyWith({
    List<CompanyAnnouncement>? companyAnnouncements,
    List<IndividualNotification>? individualNotifications,
    bool? isLoadingCompanyAnnouncement,
    bool? isLoadingIndividualNotification,
    bool? isIndividualNotificationUnlocked,
    List<IndividualNotification>? seenIndividualNotifications,
  }) {
    return AnnouncementScreenModel(
      companyAnnouncements: companyAnnouncements ?? this.companyAnnouncements,
      individualNotifications:
          individualNotifications ?? this.individualNotifications,
      isLoadingCompanyAnnouncement:
          isLoadingCompanyAnnouncement ?? this.isLoadingCompanyAnnouncement,
      isLoadingIndividualNotification: isLoadingIndividualNotification ??
          this.isLoadingIndividualNotification,
      isIndividualNotificationUnlocked: isIndividualNotificationUnlocked ??
          this.isIndividualNotificationUnlocked,
      seenIndividualNotifications:
          seenIndividualNotifications ?? this.seenIndividualNotifications,
    );
  }
}
import 'package:security_wanyu/model/company_announcement.dart';

class CompanyAnnouncementTabModel {
  final List<CompanyAnnouncement>? announcements;
  final List<CompanyAnnouncement>? seenAnnouncements;
  final bool? isLoading;
  CompanyAnnouncementTabModel({
    this.announcements,
    this.seenAnnouncements,
    this.isLoading,
  });
  List<CompanyAnnouncement> get pinnedAnnouncements =>
      announcements!.where((a) => a.pinned!).toList();
  int get unseenAnnouncementsCount =>
      announcements!.length - seenAnnouncements!.length;

  CompanyAnnouncementTabModel copyWith({
    List<CompanyAnnouncement>? announcements,
    List<CompanyAnnouncement>? seenAnnouncements,
    bool? isLoading,
  }) {
    return CompanyAnnouncementTabModel(
      announcements: announcements ?? this.announcements,
      seenAnnouncements: seenAnnouncements ?? this.seenAnnouncements,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

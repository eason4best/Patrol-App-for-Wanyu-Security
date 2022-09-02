class CompanyAnnouncement {
  final int? announcementId;
  final String? title;
  final String? content;
  final DateTime? announceDateTime;
  final bool? pinned;
  CompanyAnnouncement({
    this.announcementId,
    this.title,
    this.content,
    this.announceDateTime,
    this.pinned,
  });

  factory CompanyAnnouncement.fromData(data) {
    if (data == null) {
      return CompanyAnnouncement();
    }
    final int? announcementId = int.tryParse(data['announcement_id']);
    final String? title = data['title'];
    final String? content = data['content'];
    final DateTime? announceDateTime =
        DateTime.tryParse(data['announce_date_time']);
    final bool? pinned = data['pinned'] == null
        ? null
        : data['pinned'] == '1'
            ? true
            : false;
    return CompanyAnnouncement(
      announcementId: announcementId,
      title: title,
      content: content,
      announceDateTime: announceDateTime,
      pinned: pinned,
    );
  }
}

class MarqueeAnnouncement {
  final int? announcementId;
  final String? content;
  final DateTime? announceDateTime;
  MarqueeAnnouncement({
    this.announcementId,
    this.content,
    this.announceDateTime,
  });

  factory MarqueeAnnouncement.fromData(data) {
    if (data == null) {
      return MarqueeAnnouncement();
    }
    final int? announcementId = int.tryParse(data['announcement_id']);
    final String? content = data['content'];
    final DateTime? announceDateTime =
        DateTime.tryParse(data['announce_date_time']);
    return MarqueeAnnouncement(
      announcementId: announcementId,
      content: content,
      announceDateTime: announceDateTime,
    );
  }
}

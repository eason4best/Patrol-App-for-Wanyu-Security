class IndividualNotification {
  final int? notificationId;
  final int? memberId;
  final String? title;
  final String? content;
  final DateTime? notificationDateTime;
  final bool? pinned;
  final bool? seen;
  IndividualNotification({
    this.notificationId,
    this.memberId,
    this.title,
    this.content,
    this.notificationDateTime,
    this.pinned,
    this.seen,
  });

  factory IndividualNotification.fromData(data) {
    if (data == null) {
      return IndividualNotification();
    }
    final int? notificationId = data['notification_id'];
    final int? memberId = data['patrol_member_id'];
    final String? title = data['title'];
    final String? content = data['content'];
    final DateTime? notificationDateTime =
        DateTime.tryParse(data['notification_date_time']);
    final bool? pinned = data['pinned'] == null
        ? null
        : data['pinned'] == 1
            ? true
            : false;
    final bool? seen = data['seen'] == null
        ? null
        : data['seen'] == 1
            ? true
            : false;
    return IndividualNotification(
      notificationId: notificationId,
      memberId: memberId,
      title: title,
      content: content,
      notificationDateTime: notificationDateTime,
      pinned: pinned,
      seen: seen,
    );
  }
}

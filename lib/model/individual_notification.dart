class IndividualNotification {
  final String? notificationId;
  final int? memberId;
  final String? title;
  final String? content;
  final DateTime? notificationDateTime;
  final bool? pinned;
  IndividualNotification({
    this.notificationId,
    this.memberId,
    this.title,
    this.content,
    this.notificationDateTime,
    this.pinned,
  });

  factory IndividualNotification.fromData(data) {
    if (data == null) {
      return IndividualNotification();
    }
    final String? notificationId = data['announcement_id'];
    final int? memberId = data['patrol_member_id'];
    final String? title = data['title'];
    final String? content = data['content'];
    final DateTime? notificationDateTime =
        DateTime.tryParse(data['notification_date_time']);
    final bool? pinned = data['pinned'] == null
        ? null
        : data['pinned'] == '1'
            ? true
            : false;
    return IndividualNotification(
      notificationId: notificationId,
      memberId: memberId,
      title: title,
      content: content,
      notificationDateTime: notificationDateTime,
      pinned: pinned,
    );
  }
}

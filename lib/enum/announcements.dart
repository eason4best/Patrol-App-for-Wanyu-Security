enum Announcements {
  companyAnnouncement,
  individualNotification,
  signableDocument,
  ;

  @override
  String toString() {
    switch (this) {
      case Announcements.companyAnnouncement:
        return '公司公告';
      case Announcements.individualNotification:
        return '個人通知';
      case Announcements.signableDocument:
        return '待簽署';
    }
  }
}

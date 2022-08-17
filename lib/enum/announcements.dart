enum Announcements {
  companyAnnouncement,
  individualNotification,
  signDoc,
  ;

  @override
  String toString() {
    switch (this) {
      case Announcements.companyAnnouncement:
        return '公司公告';
      case Announcements.individualNotification:
        return '個人通知';
      case Announcements.signDoc:
        return '待簽署';
    }
  }
}

enum MainFunctions {
  startPatrol,
  shift,
  sos,
  onboard,
  formApply,
  contactUs;

  @override
  String toString() {
    switch (this) {
      case MainFunctions.startPatrol:
        return '巡邏';
      case MainFunctions.shift:
        return '班表';
      case MainFunctions.sos:
        return '緊急連絡';
      case MainFunctions.onboard:
        return '辦理入職';
      case MainFunctions.formApply:
        return '表單申請';
      case MainFunctions.contactUs:
        return '聯絡我們';
    }
  }
}

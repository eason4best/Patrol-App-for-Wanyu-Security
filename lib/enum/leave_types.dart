enum LeaveTypes {
  sick,
  personal,
  period,
  funeral,
  marriage,
  other;

  @override
  String toString() {
    switch (this) {
      case LeaveTypes.sick:
        return '病假';
      case LeaveTypes.personal:
        return '事假';
      case LeaveTypes.period:
        return '生理假';
      case LeaveTypes.funeral:
        return '喪假';
      case LeaveTypes.marriage:
        return '婚假';
      case LeaveTypes.other:
        return '其他';
    }
  }
}

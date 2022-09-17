class PatrolRecord {
  final int? customerId;
  final String? memberSN;
  final String? memberName;
  final String? patrolPlaceSN;
  final String? patrolPlaceTitle;
  final DateTime? patrolDateTime;
  final int? day;
  PatrolRecord({
    this.customerId,
    this.memberSN,
    this.memberName,
    this.patrolPlaceSN,
    this.patrolPlaceTitle,
    this.patrolDateTime,
    this.day,
  });

  Map<String, dynamic> toMap() => {
        'customerId': customerId,
        'memberSN': memberSN,
        'memberName': memberName,
        'patrolPlaceSN': patrolPlaceSN,
        'patrolPlaceTitle': patrolPlaceTitle,
        'patrolDateTime': patrolDateTime!.toString(),
        'day': day,
      };

  factory PatrolRecord.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      return PatrolRecord();
    }
    final int? customerId = data['customerId'];
    final String? memberSN = data['memberSN'];
    final String? memberName = data['memberName'];
    final String? patrolPlaceSN = data['patrolPlaceSN'];
    final String? patrolPlaceTitle = data['patrolPlaceTitle'];
    final DateTime? patrolDateTime = data['patrolDateTime'] != null
        ? DateTime.parse(data['patrolDateTime'])
        : null;
    final int? day = data['day'];
    return PatrolRecord(
      customerId: customerId,
      memberSN: memberSN,
      memberName: memberName,
      patrolPlaceSN: patrolPlaceSN,
      patrolPlaceTitle: patrolPlaceTitle,
      patrolDateTime: patrolDateTime,
      day: day,
    );
  }
}

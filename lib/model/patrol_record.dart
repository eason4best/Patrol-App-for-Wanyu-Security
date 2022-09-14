class PatrolRecord {
  final int? customerId;
  final String? memberSN;
  final String? memberName;
  final String? patrolPlaceSN;
  final String? patrolPlaceTitle;
  PatrolRecord({
    this.customerId,
    this.memberSN,
    this.memberName,
    this.patrolPlaceSN,
    this.patrolPlaceTitle,
  });

  Map<String, dynamic> toMap() => {
        'customerId': customerId,
        'memberSN': memberSN,
        'memberName': memberName,
        'patrolPlaceSN': patrolPlaceSN,
        'patrolPlaceTitle': patrolPlaceTitle,
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
    return PatrolRecord(
      customerId: customerId,
      memberSN: memberSN,
      memberName: memberName,
      patrolPlaceSN: patrolPlaceSN,
      patrolPlaceTitle: patrolPlaceTitle,
    );
  }
}

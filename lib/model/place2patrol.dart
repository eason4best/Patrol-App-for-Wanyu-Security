class Place2Patrol {
  final String? patrolPlaceSN;
  final String? patrolPlaceTitle;
  final int? customerId;
  final String? customerName;
  final int? day;

  Place2Patrol({
    this.patrolPlaceSN,
    this.patrolPlaceTitle,
    this.customerId,
    this.customerName,
    this.day,
  });

  factory Place2Patrol.fromData(data) {
    if (data == null) {
      return Place2Patrol();
    }
    final String? patrolPlaceSN = data['patrol_place_sn'];
    final String? patrolPlaceTitle = data['patrol_place_title'];
    final int? customerId = data['customer_id'];
    final String? customerName = data['customer_name'];
    final int? day = data['day'];
    return Place2Patrol(
      patrolPlaceSN: patrolPlaceSN,
      patrolPlaceTitle: patrolPlaceTitle,
      customerId: customerId,
      customerName: customerName,
      day: day,
    );
  }

  Map<String, dynamic> toMap() => {
        'patrolPlaceSN': patrolPlaceSN,
        'patrolPlaceTitle': patrolPlaceTitle,
        'customerId': customerId,
        'customerName': customerName,
        'day': day,
      };

  factory Place2Patrol.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      return Place2Patrol();
    }
    final String? patrolPlaceSN = data['patrolPlaceSN'];
    final String? patrolPlaceTitle = data['patrolPlaceTitle'];
    final int? customerId = data['customerId'];
    final String? customerName = data['customerName'];
    final int? day = data['day'];
    return Place2Patrol(
      patrolPlaceSN: patrolPlaceSN,
      patrolPlaceTitle: patrolPlaceTitle,
      customerId: customerId,
      customerName: customerName,
      day: day,
    );
  }
}

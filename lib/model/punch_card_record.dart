import 'package:security_wanyu/enum/punch_cards.dart';

class PunchCardRecord {
  final int? memberId;
  final String? memberSN;
  final String? memberName;
  final DateTime? dateTime;
  final DateTime? makeupDateTime;
  final PunchCards? punchCardType;
  final PunchCards? makeupType;
  int? customerId;
  String? customerName;
  final double? lat;
  final double? lng;
  PunchCardRecord({
    this.memberId,
    this.memberSN,
    this.memberName,
    this.dateTime,
    this.makeupDateTime,
    this.punchCardType,
    this.makeupType,
    this.customerId,
    this.customerName,
    this.lat,
    this.lng,
  });

  set setCustomerId(int? customerId) => this.customerId = customerId;
  set setCustomerName(String? customerName) => this.customerName = customerName;

  Map<String, dynamic> toMap() => {
        'patrol_member_id': memberId,
        'member_sn': memberSN,
        'member_name': memberName,
        'date_time': dateTime?.toString(),
        'punch_card_type': punchCardType.toString(),
        'makeup_type': makeupType?.toString(),
        'customer_id': customerId,
        'customer_name': customerName,
        'lat': lat,
        'lng': lng,
      };

  factory PunchCardRecord.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      return PunchCardRecord();
    }
    final int? memberId = data['patrol_member_id'];
    final String? memberSN = data['member_sn'];
    final String? memberName = data['member_name'];
    final DateTime? dateTime =
        data['date_time'] != null ? DateTime.tryParse(data['date_time']) : null;
    final PunchCards? punchCardType =
        data['punch_card_type'] == PunchCards.work.toString()
            ? PunchCards.work
            : data['punch_card_type'] == PunchCards.getOff.toString()
                ? PunchCards.getOff
                : data['punch_card_type'] == PunchCards.makeUp.toString()
                    ? PunchCards.makeUp
                    : null;
    final PunchCards? makeupType =
        data['makeup_type'] == PunchCards.work.toString()
            ? PunchCards.work
            : data['makeup_type'] == PunchCards.getOff.toString()
                ? PunchCards.getOff
                : null;
    final int? customerId = data['customer_id'];
    final String? customerName = data['customer_name'];
    final double? lat = data['lat'];
    final double? lng = data['lng'];
    return PunchCardRecord(
      memberId: memberId,
      memberSN: memberSN,
      memberName: memberName,
      dateTime: dateTime,
      punchCardType: punchCardType,
      makeupType: makeupType,
      customerId: customerId,
      customerName: customerName,
      lat: lat,
      lng: lng,
    );
  }
}

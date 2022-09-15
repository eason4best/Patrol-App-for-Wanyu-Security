import 'dart:convert';

import 'package:security_wanyu/enum/punch_cards.dart';

class PunchCardRecord {
  final int? recordId;
  final int? memberId;
  final String? memberSN;
  final String? memberName;
  final DateTime? dateTime;
  final DateTime? makeupDateTime;
  final PunchCards? punchCardType;
  final PunchCards? makeupType;
  final int? customerId;
  final String? customerName;
  final double? lat;
  final double? lng;
  PunchCardRecord({
    this.recordId,
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

  String toJSON() {
    Map<String, dynamic> data = {
      'patrol_member_id': memberId,
      'member_sn': memberSN,
      'member_name': memberName,
      //補卡時才會從APP端由使用者自行提供時間。
      'date_time': dateTime != null
          ? '${dateTime!.year}-${dateTime!.month}-${dateTime!.day} ${dateTime!.hour}:${dateTime!.minute}'
          : null,
      'punch_card_type': punchCardType.toString(),
      'makeup_type': makeupType.toString(),
      'customer_id': customerId,
      'customer_name': customerName,
      'lat': lat,
      'lng': lng,
    };
    return jsonEncode(data);
  }
}

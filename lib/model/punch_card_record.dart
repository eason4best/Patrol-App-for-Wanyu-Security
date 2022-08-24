import 'dart:convert';

import 'package:security_wanyu/enum/punch_cards.dart';

class PunchCardRecord {
  final int? recordId;
  final int? memberId;
  final String? memberSN;
  final String? memberName;
  final DateTime? dateTime;
  final PunchCards? punchCardType;
  final String? place;
  final double? lat;
  final double? lng;
  PunchCardRecord({
    this.recordId,
    this.memberId,
    this.memberSN,
    this.memberName,
    this.dateTime,
    this.punchCardType,
    this.place,
    this.lat,
    this.lng,
  });

  String toJSON() {
    Map<String, dynamic> data = {
      'patrol_member_id': memberId,
      'member_sn': memberSN,
      'member_name': memberName,
      'punch_card_type': punchCardType.toString(),
      'place': place,
      'lat': lat,
      'lng': lng,
    };
    return jsonEncode(data);
  }
}

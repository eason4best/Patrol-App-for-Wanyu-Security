import 'dart:convert';

import 'package:security_wanyu/enum/forms.dart';

class SubmitFormRecord {
  final int? recordId;
  final int? memberId;
  final Forms? formType;
  final DateTime? submitDateTime;
  final String? formFilePath;
  SubmitFormRecord({
    this.recordId,
    this.memberId,
    this.formType,
    this.submitDateTime,
    this.formFilePath,
  });

  String toJSON() {
    Map<String, dynamic> data = {
      'patrol_member_id': memberId,
      'form_type': formType.toString(),
    };
    return jsonEncode(data);
  }
}

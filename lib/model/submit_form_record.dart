import 'package:security_wanyu/enum/forms.dart';

class SubmitFormRecord {
  final int? recordId;
  final Forms? formType;
  final String? memberSN;
  final String? memberName;
  final DateTime? submitDateTime;
  final String? formFilePath;
  SubmitFormRecord({
    this.recordId,
    this.formType,
    this.memberSN,
    this.memberName,
    this.submitDateTime,
    this.formFilePath,
  });

  Map<String, String> toMap() {
    Map<String, String> data = {
      'form_type': formType.toString(),
      'member_sn': memberSN!,
      'member_name': memberName!,
    };
    return data;
  }
}

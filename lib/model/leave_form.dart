import 'dart:typed_data';

import 'package:security_wanyu/enum/leave_types.dart';

class LeaveForm {
  final String? name;
  final String? title;
  final LeaveTypes? leaveType;
  final String? leaveReason;
  final DateTime? startDateTime;
  final DateTime? endDateTime;
  final Uint8List? signatureImage;
  LeaveForm({
    this.name,
    this.title,
    this.leaveType,
    this.leaveReason,
    this.startDateTime,
    this.endDateTime,
    this.signatureImage,
  });

  LeaveForm copyWith({
    String? name,
    String? title,
    LeaveTypes? leaveType,
    String? leaveReason,
    DateTime? startDateTime,
    DateTime? endDateTime,
    Uint8List? signatureImage,
  }) {
    return LeaveForm(
      name: name ?? this.name,
      title: title ?? this.title,
      leaveType: leaveType ?? this.leaveType,
      leaveReason: leaveReason ?? this.leaveReason,
      startDateTime: startDateTime ?? this.startDateTime,
      endDateTime: endDateTime ?? this.endDateTime,
      signatureImage: signatureImage ?? this.signatureImage,
    );
  }
}

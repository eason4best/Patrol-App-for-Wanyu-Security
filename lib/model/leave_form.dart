import 'dart:typed_data';

class LeaveForm {
  final String? name;
  final String? title;
  final String? leaveType;
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
    String? leaveType,
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

  Map<String, String> toMap() {
    Map<String, String> data = {
      'name': name!,
      'title': title!,
      'leave_type': leaveType!,
      'leave_reason': leaveReason!,
      'start_date_time':
          '${startDateTime!.year}-${startDateTime!.month}-${startDateTime!.day} ${startDateTime!.hour}:${startDateTime!.minute}',
      'end_date_time':
          '${endDateTime!.year}-${endDateTime!.month}-${endDateTime!.day} ${endDateTime!.hour}:${endDateTime!.minute}',
    };
    return data;
  }
}

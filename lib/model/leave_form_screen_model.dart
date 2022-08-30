import 'package:security_wanyu/model/leave_form.dart';

class LeaveFormScreenModel {
  final LeaveForm? leaveForm;
  final bool? canSubmit;
  LeaveFormScreenModel({
    this.leaveForm,
    this.canSubmit,
  });

  LeaveFormScreenModel copyWith({
    LeaveForm? leaveForm,
    bool? canSubmit,
  }) {
    return LeaveFormScreenModel(
      leaveForm: leaveForm ?? this.leaveForm,
      canSubmit: canSubmit ?? this.canSubmit,
    );
  }
}

import 'package:security_wanyu/model/resign_form.dart';

class ResignFormScreenModel {
  final ResignForm? resignForm;
  final bool? canSubmit;
  ResignFormScreenModel({
    this.resignForm,
    this.canSubmit,
  });

  ResignFormScreenModel copyWith({
    ResignForm? resignForm,
    bool? canSubmit,
  }) {
    return ResignFormScreenModel(
      resignForm: resignForm ?? this.resignForm,
      canSubmit: canSubmit ?? this.canSubmit,
    );
  }
}

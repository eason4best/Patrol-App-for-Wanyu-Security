import 'package:security_wanyu/enum/punch_cards.dart';

class MakeUpScreenModel {
  final PunchCards? type;
  final DateTime? dateTime;
  final String? place;
  final bool? canSubmit;
  MakeUpScreenModel({
    this.type,
    this.dateTime,
    this.place,
    this.canSubmit,
  });

  MakeUpScreenModel copyWith({
    PunchCards? type,
    DateTime? dateTime,
    String? place,
    bool? canSubmit,
  }) {
    return MakeUpScreenModel(
      type: type ?? this.type,
      dateTime: dateTime ?? this.dateTime,
      place: place ?? this.place,
      canSubmit: canSubmit ?? this.canSubmit,
    );
  }
}

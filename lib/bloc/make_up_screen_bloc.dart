import 'dart:async';

import 'package:flutter/material.dart';
import 'package:security_wanyu/enum/punch_cards.dart';
import 'package:security_wanyu/model/make_up_screen_model.dart';
import 'package:security_wanyu/model/member.dart';
import 'package:security_wanyu/model/punch_card_record.dart';
import 'package:security_wanyu/service/local_database.dart';

class MakeUpScreenBloc {
  final Member member;
  MakeUpScreenBloc({required this.member});
  final StreamController<MakeUpScreenModel> _streamController =
      StreamController();
  Stream<MakeUpScreenModel> get stream => _streamController.stream;
  MakeUpScreenModel _model = MakeUpScreenModel(
      type: PunchCards.work,
      dateTime: DateTime.now(),
      place: '',
      canSubmit: false);
  MakeUpScreenModel get model => _model;
  TextEditingController placeController = TextEditingController();

  void selecPunchCardType(PunchCards? type) {
    updateWith(type: type);
  }

  Future<void> pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _model.dateTime!,
      firstDate: DateTime(1900, 1),
      lastDate: DateTime(2100, 1),
    );
    if (pickedDate != null) {
      DateTime newDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        _model.dateTime!.hour,
        _model.dateTime!.minute,
      );
      updateWith(dateTime: newDateTime);
    }
  }

  Future<void> pickTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      DateTime newDateTime = DateTime(
        _model.dateTime!.year,
        _model.dateTime!.month,
        _model.dateTime!.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      updateWith(dateTime: newDateTime);
    }
  }

  void onInputPlace(String place) {
    updateWith(place: place, canSubmit: _canSubmit());
  }

  bool _canSubmit() {
    return placeController.text.isNotEmpty;
  }

  Future<void> submit(BuildContext context) async {
    try {
      PunchCardRecord punchCardRecord = PunchCardRecord(
        memberId: member.memberId,
        memberSN: member.memberSN,
        memberName: member.memberName,
        punchCardType: PunchCards.makeUp,
        makeupType: _model.type,
        dateTime: _model.dateTime,
        customerName: _model.place,
      );
      await LocalDatabase.instance.punchCard(punchCardRecord: punchCardRecord);
    } catch (_) {
      rethrow;
    }
  }

  void updateWith({
    PunchCards? type,
    DateTime? dateTime,
    String? place,
    bool? canSubmit,
  }) {
    _model = _model.copyWith(
      type: type,
      dateTime: dateTime,
      place: place,
      canSubmit: canSubmit,
    );
    _streamController.add(_model);
  }

  void dispose() {
    placeController.dispose();
    _streamController.close();
  }
}

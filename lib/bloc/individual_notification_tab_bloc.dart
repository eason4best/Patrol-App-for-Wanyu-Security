import 'dart:async';

import 'package:flutter/material.dart';
import 'package:security_wanyu/model/individual_notification.dart';
import 'package:security_wanyu/model/individual_notification_tab_model.dart';
import 'package:security_wanyu/model/member.dart';
import 'package:security_wanyu/service/etun_api.dart';

class IndividualNotificationTabBloc {
  final Member member;
  IndividualNotificationTabBloc({required this.member}) {
    _getIndividualNotifications(memberId: member.memberId!);
  }
  final StreamController<IndividualNotificationTabModel> _streamController =
      StreamController();
  Stream<IndividualNotificationTabModel> get stream => _streamController.stream;
  IndividualNotificationTabModel _model = IndividualNotificationTabModel(
    loading: true,
    unlocked: false,
    individualNotifications: [],
  );
  IndividualNotificationTabModel get model => _model;
  TextEditingController passwordController = TextEditingController();

  Future<void> _getIndividualNotifications({required int memberId}) async {
    try {
      List<IndividualNotification> individualNotifications =
          await EtunAPI.getIndividualNotifications(memberId: memberId);
      updateWith(
          loading: false, individualNotifications: individualNotifications);
    } catch (e) {
      emitError(error: e);
    }
  }

  void onInputPassword(String password) {
    if (password == member.memberPassword) {
      updateWith(unlocked: true);
    }
  }

  void updateWith({
    bool? loading,
    bool? unlocked,
    List<IndividualNotification>? individualNotifications,
  }) {
    _model = _model.copyWith(
      loading: loading,
      unlocked: unlocked,
      individualNotifications: individualNotifications,
    );
    _streamController.add(_model);
  }

  void emitError({required Object error}) {
    _streamController.addError(error);
  }

  void dispose() {
    passwordController.dispose();
    _streamController.close();
  }
}

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:security_wanyu/model/leave_form.dart';
import 'package:security_wanyu/model/leave_form_screen_model.dart';
import 'package:signature/signature.dart';

class LeaveFormScreenBloc {
  final StreamController<LeaveFormScreenModel> _streamController =
      StreamController();
  Stream<LeaveFormScreenModel> get stream => _streamController.stream;
  LeaveFormScreenModel _model = LeaveFormScreenModel(
    leaveForm: LeaveForm(
      name: '',
      title: '',
      leaveType: '',
      leaveReason: '',
      startDateTime: DateTime.now(),
      endDateTime: DateTime.now().add(
        const Duration(days: 1),
      ),
    ),
    canSubmit: false,
  );
  LeaveFormScreenModel get model => _model;
  TextEditingController nameController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController leaveTypeController = TextEditingController();
  TextEditingController leaveReasonController = TextEditingController();
  SignatureController signatureController = SignatureController();

  void onInputName(String name) {
    updateWith(
      leaveForm: _model.leaveForm!.copyWith(name: name),
      canSubmit: _canSubmit(),
    );
  }

  void onInputTitle(String title) {
    updateWith(
      leaveForm: _model.leaveForm!.copyWith(title: title),
      canSubmit: _canSubmit(),
    );
  }

  void onInputLeaveType(String leaveType) {
    updateWith(
      leaveForm: _model.leaveForm!.copyWith(leaveType: leaveType),
      canSubmit: _canSubmit(),
    );
  }

  void onInputLeaveReason(String leaveReason) {
    updateWith(
      leaveForm: _model.leaveForm!.copyWith(leaveReason: leaveReason),
      canSubmit: _canSubmit(),
    );
  }

  Future<void> pickDate(
      {required BuildContext context, bool isStartDateTime = true}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900, 1),
      lastDate: DateTime(2100, 1),
    );
    if (pickedDate != null) {
      DateTime newDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        isStartDateTime
            ? _model.leaveForm!.startDateTime!.hour
            : _model.leaveForm!.endDateTime!.hour,
        isStartDateTime
            ? _model.leaveForm!.startDateTime!.minute
            : _model.leaveForm!.endDateTime!.minute,
      );
      if (isStartDateTime) {
        updateWith(
            leaveForm: _model.leaveForm!.copyWith(startDateTime: newDateTime));
      } else {
        updateWith(
            leaveForm: _model.leaveForm!.copyWith(endDateTime: newDateTime));
      }
    }
  }

  Future<void> pickTime(
      {required BuildContext context, bool isStartDateTime = true}) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      DateTime newDateTime = DateTime(
        isStartDateTime
            ? _model.leaveForm!.startDateTime!.year
            : _model.leaveForm!.endDateTime!.year,
        isStartDateTime
            ? _model.leaveForm!.startDateTime!.month
            : _model.leaveForm!.endDateTime!.month,
        isStartDateTime
            ? _model.leaveForm!.startDateTime!.day
            : _model.leaveForm!.endDateTime!.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      if (isStartDateTime) {
        updateWith(
            leaveForm: _model.leaveForm!.copyWith(startDateTime: newDateTime));
      } else {
        updateWith(
            leaveForm: _model.leaveForm!.copyWith(endDateTime: newDateTime));
      }
    }
  }

  Future<void> completeSigning({
    required int width,
    required int height,
    required BuildContext context,
  }) async {
    NavigatorState navigator = Navigator.of(context);
    ui.Image? signatureImage =
        await signatureController.toImage(width: width, height: height);
    final ByteData? bytes =
        await signatureImage!.toByteData(format: ui.ImageByteFormat.png);
    updateWith(
      leaveForm: _model.leaveForm!
          .copyWith(signatureImage: bytes?.buffer.asUint8List()),
      canSubmit: _canSubmit(),
    );
    navigator.pop();
  }

  bool _canSubmit() {
    return nameController.text.isNotEmpty &&
        titleController.text.isNotEmpty &&
        leaveTypeController.text.isNotEmpty &&
        leaveReasonController.text.isNotEmpty &&
        signatureController.isNotEmpty;
  }

  Future<void> submit() async {}

  void updateWith({
    LeaveForm? leaveForm,
    bool? canSubmit,
  }) {
    _model = _model.copyWith(
      leaveForm: leaveForm,
      canSubmit: canSubmit,
    );
    _streamController.add(_model);
  }

  void dispose() {
    nameController.dispose();
    titleController.dispose();
    leaveTypeController.dispose();
    leaveReasonController.dispose();
    signatureController.dispose();
    _streamController.close();
  }
}

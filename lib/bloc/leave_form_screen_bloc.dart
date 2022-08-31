import 'dart:async';
import 'dart:ui' as ui;
import 'package:docx_template/docx_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:security_wanyu/enum/forms.dart';
import 'package:security_wanyu/model/leave_form.dart';
import 'package:security_wanyu/model/leave_form_screen_model.dart';
import 'package:security_wanyu/model/member.dart';
import 'package:security_wanyu/model/submit_form_record.dart';
import 'package:security_wanyu/other/utils.dart';
import 'package:security_wanyu/screen/signing_screen.dart';
import 'package:security_wanyu/service/etun_api.dart';
import 'package:signature/signature.dart';

class LeaveFormScreenBloc {
  final Member member;
  LeaveFormScreenBloc({required this.member});
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
    FocusManager.instance.primaryFocus?.unfocus();
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
    FocusManager.instance.primaryFocus?.unfocus();
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

  void onSignaturePressed({required BuildContext context}) {
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SigningScreen(bloc: this),
    ));
  }

  Future<void> completeSigning({required BuildContext context}) async {
    NavigatorState navigator = Navigator.of(context);
    ui.Image? signatureImage = await signatureController.toImage();
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

  Future<List<int>?> _generateLeaveFormFromTemplate() async {
    try {
      ByteData templateData = await rootBundle.load('assets/leaveForm.docx');
      DocxTemplate template =
          await DocxTemplate.fromBytes(templateData.buffer.asUint8List());
      Content formContent = Content();
      formContent
        ..add(TextContent('name', _model.leaveForm!.name))
        ..add(TextContent('title', _model.leaveForm!.title))
        ..add(TextContent('leaveType', _model.leaveForm!.leaveType))
        ..add(TextContent('leaveReason', _model.leaveForm!.leaveReason))
        ..add(TextContent(
          'startDateTime',
          Utils.datetimeString(
            _model.leaveForm!.startDateTime!,
            showWeekday: true,
            isMinguo: true,
          ),
        ))
        ..add(TextContent(
          'endDateTime',
          Utils.datetimeString(
            _model.leaveForm!.endDateTime!,
            showWeekday: true,
            isMinguo: true,
          ),
        ))
        ..add(ImageContent('signatureImage',
            _model.leaveForm!.signatureImage!.toList(growable: false)));
      return await template.generate(formContent,
          tagPolicy: TagPolicy.removeAll);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> submit({required BuildContext context}) async {
    NavigatorState navigator = Navigator.of(context);
    List<int>? formData = await _generateLeaveFormFromTemplate();
    bool result = await EtunAPI.submitForm(
      formData: formData!,
      formRecord: SubmitFormRecord(
        formType: Forms.leave,
        memberSN: member.memberSN,
        memberName: member.memberName,
      ),
    );
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(result ? '表單提交成功' : '表單提交失敗'),
        content: Text(result ? '請假單提交成功！' : '請假單提交失敗，請再試一次。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              '確認',
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
    navigator.pop();
  }

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

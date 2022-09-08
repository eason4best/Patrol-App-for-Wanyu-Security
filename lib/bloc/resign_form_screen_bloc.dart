import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:docx_template/docx_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:security_wanyu/enum/forms.dart';
import 'package:security_wanyu/model/member.dart';
import 'package:security_wanyu/model/resign_form.dart';
import 'package:security_wanyu/model/resign_form_screen_model.dart';
import 'package:security_wanyu/model/submit_form_record.dart';
import 'package:security_wanyu/screen/signing_screen.dart';
import 'package:security_wanyu/service/etun_api.dart';
import 'package:security_wanyu/other/utils.dart';
import 'package:signature/signature.dart';

class ResignFormScreenBloc {
  final Member member;
  ResignFormScreenBloc({required this.member});
  final StreamController<ResignFormScreenModel> _streamController =
      StreamController();
  Stream<ResignFormScreenModel> get stream => _streamController.stream;
  ResignFormScreenModel _model = ResignFormScreenModel(
    resignForm: ResignForm(
      name: '',
      idNumber: '',
      title: '',
      resignReason: '',
      resignDate: DateTime.now(),
    ),
    canSubmit: false,
  );
  ResignFormScreenModel get model => _model;
  TextEditingController nameController = TextEditingController();
  TextEditingController idNumberController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController resignReasonController = TextEditingController();
  TextEditingController resignDateController = TextEditingController();
  SignatureController signatureController = SignatureController();

  void onInputName(String name) {
    updateWith(
      resignForm: _model.resignForm!.copyWith(name: name),
      canSubmit: _canSubmit(),
    );
  }

  void onInputIdNumber(String idNumber) {
    updateWith(
      resignForm: _model.resignForm!.copyWith(idNumber: idNumber),
      canSubmit: _canSubmit(),
    );
  }

  void onInputTitle(String title) {
    updateWith(
      resignForm: _model.resignForm!.copyWith(title: title),
      canSubmit: _canSubmit(),
    );
  }

  void onInputResignReason(String resignReason) {
    updateWith(
      resignForm: _model.resignForm!.copyWith(resignReason: resignReason),
      canSubmit: _canSubmit(),
    );
  }

  Future<void> pickDate({required BuildContext context}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900, 1),
      lastDate: DateTime(2100, 1),
    );
    if (pickedDate != null) {
      resignDateController.text = Utils.datetimeString(
        pickedDate,
        onlyDate: true,
        showWeekday: true,
        isMinguo: true,
      );
      updateWith(
          resignForm: _model.resignForm!.copyWith(resignDate: pickedDate));
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
    if (signatureController.isNotEmpty) {
      ui.Image? signatureImage = await signatureController.toImage();
      final ByteData? bytes =
          await signatureImage!.toByteData(format: ui.ImageByteFormat.png);
      updateWith(
        resignForm: _model.resignForm!
            .copyWith(signatureImage: bytes?.buffer.asUint8List()),
        canSubmit: _canSubmit(),
      );
    }
    navigator.pop();
  }

  void clearSigning() {
    signatureController.clear();
    updateWith(
      resignForm:
          _model.resignForm!.copyWith(signatureImage: Uint8List.fromList([])),
      canSubmit: _canSubmit(),
    );
  }

  bool _canSubmit() {
    return nameController.text.isNotEmpty &&
        idNumberController.text.isNotEmpty &&
        titleController.text.isNotEmpty &&
        resignReasonController.text.isNotEmpty &&
        signatureController.isNotEmpty;
  }

  Future<List<int>?> _generateResignFormFromTemplate() async {
    try {
      ByteData templateData = await rootBundle.load('assets/resignForm.docx');
      DocxTemplate template =
          await DocxTemplate.fromBytes(templateData.buffer.asUint8List());
      Content formContent = Content();
      formContent
        ..add(TextContent('name', _model.resignForm!.name))
        ..add(TextContent('idNumber', _model.resignForm!.idNumber))
        ..add(TextContent('title', _model.resignForm!.title))
        ..add(TextContent('resignReason', _model.resignForm!.resignReason))
        ..add(TextContent(
          'resignDate',
          Utils.datetimeString(
            _model.resignForm!.resignDate!,
            onlyDate: true,
            showWeekday: true,
            isMinguo: true,
          ),
        ))
        ..add(ImageContent('signatureImage',
            _model.resignForm!.signatureImage!.toList(growable: false)));
      return await template.generate(formContent);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> submit({required BuildContext context}) async {
    NavigatorState navigator = Navigator.of(context);
    List<int>? formData = await _generateResignFormFromTemplate();
    bool result = await EtunAPI.submitForm(
      formData: formData!,
      formRecord: SubmitFormRecord(
        memberId: member.memberId,
        formType: Forms.resign,
      ),
    );
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(result ? '表單提交成功' : '表單提交失敗'),
        content: Text(result ? '離職單提交成功！' : '離職單提交失敗，請再試一次。'),
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
    ResignForm? resignForm,
    bool? canSubmit,
  }) {
    _model = _model.copyWith(
      resignForm: resignForm,
      canSubmit: canSubmit,
    );
    _streamController.add(_model);
  }

  void dispose() {
    nameController.dispose();
    idNumberController.dispose();
    titleController.dispose();
    resignReasonController.dispose();
    resignDateController.dispose();
    signatureController.dispose();
    _streamController.close();
  }
}

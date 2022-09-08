import 'dart:async';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:security_wanyu/enum/onboard_documents.dart';
import 'package:security_wanyu/model/member.dart';
import 'package:security_wanyu/model/submit_onboard_document_record.dart';
import 'package:security_wanyu/model/upload_document_screen_model.dart';
import 'package:security_wanyu/service/etun_api.dart';

class UploadHeadshotScreenBloc {
  final Member member;
  UploadHeadshotScreenBloc({required this.member});
  final StreamController<UploadDocumentScreenModel> _streamController =
      StreamController();
  Stream<UploadDocumentScreenModel> get stream => _streamController.stream;
  UploadDocumentScreenModel _model =
      UploadDocumentScreenModel(canSubmit: false);
  UploadDocumentScreenModel get model => _model;

  Future<void> takeImage({required CameraController cameraController}) async {
    XFile xFile = await cameraController.takePicture();
    Uint8List image = await xFile.readAsBytes();
    updateWith(
      image1: image,
      canSubmit: true,
    );
  }

  Future<bool> submit() async {
    bool result = await EtunAPI.submitOnboardDocument(
      documentImage: [_model.image1!.toList()],
      onboardDocumentRecord: SubmitOnboardDocumentRecord(
        memberId: member.memberId,
        onboardDocumentType: OnboardDocuments.headshot,
      ),
    );
    return result;
  }

  void updateWith({
    Uint8List? image1,
    Uint8List? image2,
    bool? canSubmit,
  }) {
    _model = _model.copyWith(
      image1: image1,
      image2: image2,
      canSubmit: canSubmit,
    );
    _streamController.add(_model);
  }

  void dispose() {
    _streamController.close();
  }
}

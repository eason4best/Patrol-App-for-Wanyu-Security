import 'dart:async';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:security_wanyu/model/upload_document_screen_model.dart';

class UploadIdCardScreenBloc {
  final StreamController<UploadDocumentScreenModel> _streamController =
      StreamController();
  Stream<UploadDocumentScreenModel> get stream => _streamController.stream;
  UploadDocumentScreenModel _model =
      UploadDocumentScreenModel(canSubmit: false);
  UploadDocumentScreenModel get model => _model;

  Future<void> takeFrontImage(
      {required CameraController cameraController}) async {
    XFile xFile = await cameraController.takePicture();
    Uint8List frontImage = await xFile.readAsBytes();
    updateWith(
      image1: frontImage,
      canSubmit: _model.image2 != null,
    );
  }

  Future<void> takeBackImage(
      {required CameraController cameraController}) async {
    XFile xFile = await cameraController.takePicture();
    Uint8List backImage = await xFile.readAsBytes();
    updateWith(
      image2: backImage,
      canSubmit: _model.image1 != null,
    );
  }

  Future<void> submit() async {}

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

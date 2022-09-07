import 'dart:async';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:security_wanyu/model/upload_id_card_screen_model.dart';

class UploadIdCardScreenBloc {
  final StreamController<UploadIdCardScreenModel> _streamController =
      StreamController();
  Stream<UploadIdCardScreenModel> get stream => _streamController.stream;
  UploadIdCardScreenModel _model = UploadIdCardScreenModel(canSubmit: false);
  UploadIdCardScreenModel get model => _model;

  Future<void> takeFrontImage(
      {required CameraController cameraController}) async {
    XFile xFile = await cameraController.takePicture();
    Uint8List frontImage = await xFile.readAsBytes();
    updateWith(
      frontImage: frontImage,
      canSubmit: _model.backImage != null,
    );
  }

  Future<void> takeBackImage(
      {required CameraController cameraController}) async {
    XFile xFile = await cameraController.takePicture();
    Uint8List backImage = await xFile.readAsBytes();
    updateWith(
      backImage: backImage,
      canSubmit: _model.frontImage != null,
    );
  }

  Future<void> submit() async {}

  bool get canSubmit => _model.frontImage != null && _model.backImage != null;

  void updateWith({
    Uint8List? frontImage,
    Uint8List? backImage,
    bool? canSubmit,
  }) {
    _model = _model.copyWith(
      frontImage: frontImage,
      backImage: backImage,
      canSubmit: canSubmit,
    );
    _streamController.add(_model);
  }

  void dispose() {
    _streamController.close();
  }
}

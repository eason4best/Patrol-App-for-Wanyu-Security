import 'dart:async';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:security_wanyu/model/upload_document_screen_model.dart';

class UploadOtherDocumentScreenBloc {
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

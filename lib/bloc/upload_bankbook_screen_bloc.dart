import 'dart:async';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:security_wanyu/model/upload_bankbook_screen_model.dart';

class UploadBankbookScreenBloc {
  final StreamController<UploadBankbookScreenModel> _streamController =
      StreamController();
  Stream<UploadBankbookScreenModel> get stream => _streamController.stream;
  UploadBankbookScreenModel _model =
      UploadBankbookScreenModel(canSubmit: false);
  UploadBankbookScreenModel get model => _model;

  Future<void> takeImage({required CameraController cameraController}) async {
    XFile xFile = await cameraController.takePicture();
    Uint8List image = await xFile.readAsBytes();
    updateWith(
      image: image,
      canSubmit: _model.image != null,
    );
  }

  Future<void> submit() async {}

  bool get canSubmit => _model.image != null;

  void updateWith({
    Uint8List? image,
    bool? canSubmit,
  }) {
    _model = _model.copyWith(
      image: image,
      canSubmit: canSubmit,
    );
    _streamController.add(_model);
  }

  void dispose() {
    _streamController.close();
  }
}

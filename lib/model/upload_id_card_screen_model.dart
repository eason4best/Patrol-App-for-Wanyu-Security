import 'dart:typed_data';

class UploadIdCardScreenModel {
  final Uint8List? frontImage;
  final Uint8List? backImage;
  final bool? canSubmit;
  UploadIdCardScreenModel({
    this.frontImage,
    this.backImage,
    this.canSubmit,
  });

  UploadIdCardScreenModel copyWith({
    Uint8List? frontImage,
    Uint8List? backImage,
    bool? canSubmit,
  }) {
    return UploadIdCardScreenModel(
      frontImage: frontImage ?? this.frontImage,
      backImage: backImage ?? this.backImage,
      canSubmit: canSubmit ?? this.canSubmit,
    );
  }
}

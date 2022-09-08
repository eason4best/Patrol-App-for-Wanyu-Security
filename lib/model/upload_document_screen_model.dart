import 'dart:typed_data';

class UploadDocumentScreenModel {
  final Uint8List? image1;
  final Uint8List? image2;
  final bool? canSubmit;
  UploadDocumentScreenModel({
    this.image1,
    this.image2,
    this.canSubmit,
  });

  UploadDocumentScreenModel copyWith({
    Uint8List? image1,
    Uint8List? image2,
    bool? canSubmit,
  }) {
    return UploadDocumentScreenModel(
      image1: image1 ?? this.image1,
      image2: image2 ?? this.image2,
      canSubmit: canSubmit ?? this.canSubmit,
    );
  }
}

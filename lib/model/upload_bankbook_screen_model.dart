import 'dart:typed_data';

class UploadBankbookScreenModel {
  final Uint8List? image;
  final bool? canSubmit;
  UploadBankbookScreenModel({
    this.image,
    this.canSubmit,
  });

  UploadBankbookScreenModel copyWith({
    Uint8List? image,
    bool? canSubmit,
  }) {
    return UploadBankbookScreenModel(
      image: image ?? this.image,
      canSubmit: canSubmit ?? this.canSubmit,
    );
  }
}

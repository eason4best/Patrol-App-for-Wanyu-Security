import 'dart:typed_data';

class SignDocumentScreenModel {
  final Uint8List? documentBytes;
  final Uint8List? signedDocumentBytes;
  final Uint8List? signatureImage;
  final bool? canSubmit;

  SignDocumentScreenModel({
    this.documentBytes,
    this.signedDocumentBytes,
    this.signatureImage,
    this.canSubmit,
  });

  SignDocumentScreenModel copyWith({
    Uint8List? documentBytes,
    Uint8List? signedDocumentBytes,
    Uint8List? signatureImage,
    bool? canSubmit,
  }) {
    return SignDocumentScreenModel(
      documentBytes: documentBytes ?? this.documentBytes,
      signedDocumentBytes: signedDocumentBytes ?? this.signedDocumentBytes,
      signatureImage: signatureImage ?? this.signatureImage,
      canSubmit: canSubmit ?? this.canSubmit,
    );
  }
}

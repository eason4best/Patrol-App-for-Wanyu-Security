import 'dart:typed_data';

class ResignForm {
  final String? name;
  final String? idNumber;
  final String? title;
  final String? resignReason;
  final DateTime? resignDate;
  final Uint8List? signatureImage;
  ResignForm({
    this.name,
    this.idNumber,
    this.title,
    this.resignReason,
    this.resignDate,
    this.signatureImage,
  });

  ResignForm copyWith({
    String? name,
    String? idNumber,
    String? title,
    String? resignReason,
    DateTime? resignDate,
    Uint8List? signatureImage,
  }) {
    return ResignForm(
      name: name ?? this.name,
      idNumber: idNumber ?? this.idNumber,
      title: title ?? this.title,
      resignReason: resignReason ?? this.resignReason,
      resignDate: resignDate ?? this.resignDate,
      signatureImage: signatureImage ?? this.signatureImage,
    );
  }
}

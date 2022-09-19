import 'dart:async';
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:security_wanyu/model/sign_document_screen_model.dart';
import 'package:security_wanyu/model/submit_signed_document_record.dart';
import 'package:security_wanyu/service/etun_api.dart';
import 'package:signature/signature.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class SignDocumentScreenBloc {
  SignDocumentScreenBloc({required Uint8List documentBytes}) {
    _model = SignDocumentScreenModel(documentBytes: documentBytes);
  }
  final StreamController<SignDocumentScreenModel> _streamController =
      StreamController();
  Stream<SignDocumentScreenModel> get stream => _streamController.stream;
  late SignDocumentScreenModel _model;
  SignatureController signatureController = SignatureController();

  Future<void> completeSigning() async {
    if (signatureController.isNotEmpty) {
      ui.Image? signatureImage = await signatureController.toImage();
      ByteData? byteData =
          await signatureImage!.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? signatureBytes = byteData?.buffer.asUint8List();
      PdfDocument signedDocument =
          PdfDocument(inputBytes: _model.documentBytes);
      PdfTextBoxField textBoxField = signedDocument
          .form.fields[signedDocument.form.fields.count - 1] as PdfTextBoxField;
      PdfPage signedPage = signedDocument.pages[signedDocument.pages.count - 1];
      PdfSignatureField signatureField = PdfSignatureField(
        signedPage,
        'signature',
        bounds: textBoxField.bounds,
      );
      signatureField.appearance.normal.graphics?.drawImage(
        PdfBitmap(signatureBytes!),
        ui.Rect.fromLTWH(
            0, 0, textBoxField.bounds.width, textBoxField.bounds.height),
      );
      signedDocument.form.fields.add(signatureField);
      signedDocument.form.flattenAllFields();
      Uint8List documentBytes = Uint8List.fromList(await signedDocument.save());
      signedDocument.dispose();
      updateWith(
        signedDocumentBytes: documentBytes,
        signatureImage: signatureBytes,
        canSubmit: _canSubmit(),
      );
    }
  }

  void clearSigning() {
    signatureController.clear();
    updateWith(
      signatureImage: Uint8List.fromList([]),
      canSubmit: _canSubmit(),
    );
  }

  bool _canSubmit() {
    return signatureController.isNotEmpty;
  }

  Future<void> submit() async {
    try {
      await EtunAPI.instance.submitSignedDocument(
        signedDocumentData: _model.signedDocumentBytes!.toList(),
        signedDocumentRecord:
            SubmitSignedDocumentRecord(memberId: 9, documentId: 2),
      );
    } catch (e) {
      rethrow;
    }
  }

  void updateWith({
    Uint8List? documentBytes,
    Uint8List? signedDocumentBytes,
    Uint8List? signatureImage,
    bool? canSubmit,
  }) {
    _model = _model.copyWith(
      documentBytes: documentBytes,
      signedDocumentBytes: signedDocumentBytes,
      signatureImage: signatureImage,
      canSubmit: canSubmit,
    );
    _streamController.add(_model);
  }

  void dispose() {
    signatureController.dispose();
    _streamController.close();
  }
}

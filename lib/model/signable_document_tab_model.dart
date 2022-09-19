import 'package:security_wanyu/model/signable_document.dart';

class SignableDocumentTabModel {
  final List<SignableDocument>? docs;
  final List<SignableDocument>? signedDocs;
  final bool? isLoading;
  SignableDocumentTabModel({
    this.docs,
    this.signedDocs,
    this.isLoading,
  });
  List<SignableDocument> get pinnedDocs =>
      docs!.where((d) => d.pinned!).toList();
  int get unsignedDocsCount => docs!.length - signedDocs!.length;

  SignableDocumentTabModel copyWith({
    List<SignableDocument>? docs,
    List<SignableDocument>? signedDocs,
    bool? isLoading,
  }) {
    return SignableDocumentTabModel(
      docs: docs ?? this.docs,
      signedDocs: signedDocs ?? this.signedDocs,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

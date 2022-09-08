import 'package:security_wanyu/model/signable_document.dart';

class SignableDocumentTabModel {
  final List<SignableDocument>? docs;
  final bool? isLoading;
  SignableDocumentTabModel({
    this.docs,
    this.isLoading,
  });
  List<SignableDocument> get pinnedDocs =>
      docs!.where((d) => d.pinned!).toList();

  SignableDocumentTabModel copyWith({
    List<SignableDocument>? docs,
    bool? isLoading,
  }) {
    return SignableDocumentTabModel(
      docs: docs,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

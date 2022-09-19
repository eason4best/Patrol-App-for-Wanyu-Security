class SignableDocument {
  final int? docId;
  final String? title;
  final DateTime? publishDateTime;
  final bool? pinned;
  final String? docFilePath;
  SignableDocument({
    this.docId,
    this.title,
    this.publishDateTime,
    this.pinned,
    this.docFilePath,
  });

  factory SignableDocument.fromData(data) {
    if (data == null) {
      return SignableDocument();
    }
    final int? docId = data['doc_id'];
    final String? title = data['title'];
    final DateTime? publishDateTime =
        DateTime.tryParse(data['publish_date_time']);
    final bool? pinned = data['pinned'] == null
        ? null
        : data['pinned'] == 1
            ? true
            : false;
    final String? docFilePath = data['docFilePath'];
    return SignableDocument(
      docId: docId,
      title: title,
      publishDateTime: publishDateTime,
      pinned: pinned,
      docFilePath: docFilePath,
    );
  }
}

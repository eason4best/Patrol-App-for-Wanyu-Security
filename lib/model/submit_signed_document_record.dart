import 'dart:convert';

class SubmitSignedDocumentRecord {
  final int? recordId;
  final int? memberId;
  final int? documentId;
  final DateTime? submitDateTime;
  final String? signedDocumentPath;
  SubmitSignedDocumentRecord({
    this.recordId,
    this.memberId,
    this.documentId,
    this.submitDateTime,
    this.signedDocumentPath,
  });

  String toJSON() {
    Map<String, dynamic> data = {
      'patrol_member_id': memberId,
      'doc_id': documentId,
    };
    return jsonEncode(data);
  }
}

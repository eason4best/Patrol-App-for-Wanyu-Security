import 'dart:convert';

import 'package:security_wanyu/enum/onboard_documents.dart';

class SubmitOnboardDocumentRecord {
  final int? recordId;
  final int? memberId;
  final OnboardDocuments? onboardDocumentType;
  final DateTime? submitDateTime;
  final String? onboardDocumentImagePaths;
  SubmitOnboardDocumentRecord({
    this.recordId,
    this.memberId,
    this.onboardDocumentType,
    this.submitDateTime,
    this.onboardDocumentImagePaths,
  });

  String toJSON() {
    Map<String, dynamic> data = {
      'patrol_member_id': memberId,
      'onboard_document_type': onboardDocumentType.toString(),
    };
    return jsonEncode(data);
  }
}

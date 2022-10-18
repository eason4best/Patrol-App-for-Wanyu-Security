import 'package:flutter/material.dart';
import 'package:security_wanyu/enum/onboard_documents.dart';

class TakeDocumentImageFrame extends StatelessWidget {
  final OnboardDocuments? documentType;
  const TakeDocumentImageFrame({
    Key? key,
    this.documentType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.width *
          0.8 /
          documentType!.aspectRatio()!,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: Text(
          documentType == OnboardDocuments.headshot
              ? '請確認臉部於藍框內再拍照'
              : '請確認${documentType.toString()}於藍框內再拍照',
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.white.withOpacity(0.8)),
        ),
      ),
    );
  }
}

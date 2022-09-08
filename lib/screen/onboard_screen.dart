import 'package:flutter/material.dart';
import 'package:security_wanyu/enum/onboard_documents.dart';
import 'package:security_wanyu/model/member.dart';
import 'package:security_wanyu/screen/upload_bankbook_screen.dart';
import 'package:security_wanyu/screen/upload_headshot_screen.dart';
import 'package:security_wanyu/screen/upload_id_card_screen.dart';
import 'package:security_wanyu/screen/upload_other_document_screen.dart';

class OnBoardScreen extends StatelessWidget {
  final Member member;
  const OnBoardScreen({
    Key? key,
    required this.member,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('辦理入職'),
      ),
      body: ListView.builder(
        itemCount: OnboardDocuments.values.length,
        itemBuilder: (context, index) => ListTile(
          title: Text('${OnboardDocuments.values[index].toString()}上傳'),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OnboardDocuments.values[index] ==
                    OnboardDocuments.idCard
                ? UploadIdCardScreen.create(member: member)
                : OnboardDocuments.values[index] == OnboardDocuments.bankbook
                    ? UploadBankbookScreen.create(member: member)
                    : OnboardDocuments.values[index] ==
                            OnboardDocuments.headshot
                        ? UploadHeadshotScreen.create(member: member)
                        : UploadOtherDocumentScreen.create(member: member),
          )),
        ),
      ),
    );
  }
}

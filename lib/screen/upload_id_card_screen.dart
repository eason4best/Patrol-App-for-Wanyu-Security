import 'package:flutter/material.dart';
import 'package:security_wanyu/widget/upload_onboard_document_widget.dart';

class UploadIdCardScreen extends StatelessWidget {
  const UploadIdCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('身份證上傳'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              UploadOnboardDocumentWidget(
                content: '拍攝身分證正面',
                aspectRatio: 85.7 / 54,
                onTap: () {},
              ),
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: UploadOnboardDocumentWidget(
                  content: '拍攝身分證反面',
                  aspectRatio: 85.7 / 54,
                  onTap: () {},
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 56,
                margin: const EdgeInsets.only(top: 32, bottom: 16),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0.0),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: const Center(child: Text('上傳')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

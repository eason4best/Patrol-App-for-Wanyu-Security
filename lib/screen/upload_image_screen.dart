import 'package:flutter/material.dart';
import 'package:security_wanyu/widget/sub_functions_button.dart';

class UploadImageScreen extends StatelessWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('上傳圖片資料'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SubFunctionsButton(
                title: '上傳圖片',
                onPressed: () {},
              ),
              Container(
                margin: const EdgeInsets.only(top: 16.0),
                child: SubFunctionsButton(
                  title: '瀏覽已上傳圖片',
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

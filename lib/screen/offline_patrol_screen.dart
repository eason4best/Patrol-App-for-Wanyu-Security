import 'package:flutter/material.dart';
import 'package:security_wanyu/widget/sub_functions_button.dart';

class OfflinePatrolScreen extends StatelessWidget {
  const OfflinePatrolScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('離線巡邏'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SubFunctionsButton(
                title: '離線巡邏',
                onPressed: () {},
              ),
              Container(
                margin: const EdgeInsets.only(top: 16.0),
                child: SubFunctionsButton(
                  title: '清空巡邏紀錄',
                  onPressed: () {},
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 16.0),
                child: SubFunctionsButton(
                  title: '上傳巡邏資料',
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

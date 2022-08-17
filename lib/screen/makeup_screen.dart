import 'package:flutter/material.dart';
import 'package:security_wanyu/utils.dart';

class MakeUpScreen extends StatelessWidget {
  const MakeUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('補卡'),
      ),
      body: Column(
        children: [
          ListTile(
            tileColor: Colors.white,
            leading: const Icon(Icons.schedule_outlined),
            title: Text(Utils.currentDateString()),
            trailing: Text(
              Utils.currentTimeString(),
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Divider(
            color: Theme.of(context).scaffoldBackgroundColor,
            height: 0,
          ),
          ListTile(
            tileColor: Colors.white,
            leading: const Icon(Icons.location_on_outlined),
            title: Text(
              '請選擇地點',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: Colors.black54),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width - 32,
            height: 56,
            margin: const EdgeInsets.only(top: 32),
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
              child: const Center(child: Text('確認')),
            ),
          )
        ],
      ),
    );
  }
}

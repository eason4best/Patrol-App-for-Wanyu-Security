import 'package:flutter/material.dart';
import 'package:security_wanyu/service/utils.dart';

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
          const ListTile(
            tileColor: Colors.white,
            leading: Icon(Icons.location_on_outlined),
            title: SizedBox(
              height: 48,
              child: TextField(
                decoration: InputDecoration(
                  hintText: '請輸入地點',
                  contentPadding: EdgeInsets.all(0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
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

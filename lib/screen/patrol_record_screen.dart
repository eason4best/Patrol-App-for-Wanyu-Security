import 'package:flutter/material.dart';

class PatrolRecordScreen extends StatelessWidget {
  const PatrolRecordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('巡邏紀錄'),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            title: Text(
              '待巡邏',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          const ListTile(
            title: Text('二廠北側門一'),
          ),
          const ListTile(
            title: Text('二廠北側門二'),
          ),
          const ListTile(
            title: Text('一廠南側門一'),
          ),
          const ListTile(
            title: Text('一廠南側門二'),
          ),
          const ListTile(
            title: Text('一廠東側門'),
          ),
          const ListTile(
            title: Text('一廠北側門'),
          ),
          const ListTile(
            title: Text('一廠大廳'),
          ),
          const ListTile(
            title: Text('一廠西側門'),
          ),
          const Divider(
            height: 0,
            thickness: 1,
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: ListTile(
              title: Text(
                '已完成',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.check_circle_outline,
              color: Theme.of(context).primaryColor,
            ),
            title: const Text('二廠大廳'),
          ),
          ListTile(
            leading: Icon(
              Icons.check_circle_outline,
              color: Theme.of(context).primaryColor,
            ),
            title: const Text('二廠西側門'),
          ),
          ListTile(
            leading: Icon(
              Icons.check_circle_outline,
              color: Theme.of(context).primaryColor,
            ),
            title: const Text('二廠南側門'),
          ),
          ListTile(
            leading: Icon(
              Icons.check_circle_outline,
              color: Theme.of(context).primaryColor,
            ),
            title: const Text('二廠東側門'),
          ),
        ],
      ),
    );
  }
}

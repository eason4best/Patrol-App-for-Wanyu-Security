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
            title: Text('巡邏點E'),
          ),
          const ListTile(
            title: Text('巡邏點F'),
          ),
          const ListTile(
            title: Text('巡邏點G'),
          ),
          const ListTile(
            title: Text('巡邏點H'),
          ),
          const ListTile(
            title: Text('巡邏點I'),
          ),
          const ListTile(
            title: Text('巡邏點J'),
          ),
          const ListTile(
            title: Text('巡邏點K'),
          ),
          const ListTile(
            title: Text('巡邏點L'),
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
          const ListTile(
            title: Text(
              '巡邏點A',
              style: TextStyle(color: Colors.black54),
            ),
          ),
          const ListTile(
            title: Text(
              '巡邏點B',
              style: TextStyle(color: Colors.black54),
            ),
          ),
          const ListTile(
            title: Text(
              '巡邏點C',
              style: TextStyle(color: Colors.black54),
            ),
          ),
          const ListTile(
            title: Text(
              '巡邏點D',
              style: TextStyle(color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}

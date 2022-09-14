import 'package:flutter/material.dart';
import 'package:security_wanyu/model/place2patrol.dart';

class PatrolRecordScreen extends StatelessWidget {
  final List<Place2Patrol> donePlaces2Patrol;
  final List<Place2Patrol> undonePlaces2Patrol;
  const PatrolRecordScreen({
    Key? key,
    required this.donePlaces2Patrol,
    required this.undonePlaces2Patrol,
  }) : super(key: key);

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
          ...List.generate(
            undonePlaces2Patrol.length,
            (index) => ListTile(
              title: Text(undonePlaces2Patrol[index].patrolPlaceTitle!),
            ),
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
          ...List.generate(
            donePlaces2Patrol.length,
            (index) => ListTile(
              leading: Icon(
                Icons.check_circle_outline,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(donePlaces2Patrol[index].patrolPlaceTitle!),
            ),
          ),
        ],
      ),
    );
  }
}

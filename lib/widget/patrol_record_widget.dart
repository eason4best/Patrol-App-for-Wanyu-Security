import 'package:flutter/material.dart';
import 'package:security_wanyu/model/place2patrol.dart';

class PatrolRecordWidget extends StatelessWidget {
  final List<Place2Patrol> donePlaces2Patrol;
  final List<Place2Patrol> undonePlaces2Patrol;
  const PatrolRecordWidget({
    super.key,
    required this.donePlaces2Patrol,
    required this.undonePlaces2Patrol,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(0.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(
              undonePlaces2Patrol.isNotEmpty
                  ? '${undonePlaces2Patrol[0].customerName!}${'・執勤中'}'
                  : '${donePlaces2Patrol[0].customerName!}${'・執勤中'}',
              style: Theme.of(context).textTheme.subtitle2,
            ),
            tileColor: Theme.of(context).scaffoldBackgroundColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
          ),
          ...List.generate(
            undonePlaces2Patrol.length,
            (index) => ListTile(
              title: Text(
                undonePlaces2Patrol[index].patrolPlaceTitle!,
                style: const TextStyle(color: Colors.black87),
              ),
              trailing: Text(
                '待巡邏',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ),
          ...List.generate(
            donePlaces2Patrol.length,
            (index) => ListTile(
              title: Text(
                donePlaces2Patrol[index].patrolPlaceTitle!,
                style: const TextStyle(color: Colors.black),
              ),
              trailing: Text(
                '已完成',
                style: Theme.of(context).textTheme.caption!.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

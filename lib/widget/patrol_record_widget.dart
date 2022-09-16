import 'package:flutter/material.dart';
import 'package:security_wanyu/model/place2patrol.dart';

class PatrolRecordWidget extends StatelessWidget {
  final List<Place2Patrol> donePlaces2Patrol;
  final List<Place2Patrol> undonePlaces2Patrol;
  final bool enabled;
  const PatrolRecordWidget({
    super.key,
    required this.donePlaces2Patrol,
    required this.undonePlaces2Patrol,
    this.enabled = true,
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
        children: [
          ListTile(
            title: Text(
              undonePlaces2Patrol.isNotEmpty
                  ? '${undonePlaces2Patrol[0].customerName!}${enabled ? '・執勤中' : ''}'
                  : '${donePlaces2Patrol[0].customerName!}${enabled ? '・執勤中' : ''}',
              style: enabled
                  ? Theme.of(context).textTheme.subtitle2
                  : Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: Colors.black38),
            ),
            tileColor: enabled
                ? Theme.of(context).scaffoldBackgroundColor
                : Colors.black12,
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
                style:
                    TextStyle(color: enabled ? Colors.black87 : Colors.black38),
              ),
              trailing: Text(
                '待巡邏',
                style: enabled
                    ? Theme.of(context).textTheme.caption
                    : Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: Colors.black38),
              ),
            ),
          ),
          ...List.generate(
            donePlaces2Patrol.length,
            (index) => ListTile(
              title: Text(
                donePlaces2Patrol[index].patrolPlaceTitle!,
                style:
                    TextStyle(color: enabled ? Colors.black : Colors.black38),
              ),
              trailing: Text(
                '已完成',
                style: Theme.of(context).textTheme.caption!.copyWith(
                      color: enabled
                          ? Theme.of(context).primaryColor
                          : Colors.black38,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

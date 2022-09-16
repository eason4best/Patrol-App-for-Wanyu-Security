import 'package:flutter/material.dart';
import 'package:security_wanyu/model/place2patrol.dart';
import 'package:security_wanyu/widget/patrol_record_widget.dart';

class PatrolRecordScreen extends StatelessWidget {
  final List<Place2Patrol> donePlaces2Patrol;
  final List<Place2Patrol> undonePlaces2Patrol;
  final int customerId;
  const PatrolRecordScreen({
    Key? key,
    required this.donePlaces2Patrol,
    required this.undonePlaces2Patrol,
    required this.customerId,
  }) : super(key: key);

  List<Map<String, List<Place2Patrol>>> get _places2PatrolGroupByCustomer {
    List<int> customerIds = Set<int>.from(
        List<Place2Patrol>.from([...donePlaces2Patrol, ...undonePlaces2Patrol])
            .map((pp) => pp.customerId)).toList();
    if (customerIds.remove(customerId)) {
      customerIds.insert(0, customerId);
      List<Map<String, List<Place2Patrol>>> result = [];
      for (var id in customerIds) {
        Map<String, List<Place2Patrol>> place2patrol = {
          'donePlaces2Patrol':
              donePlaces2Patrol.where((dpp) => dpp.customerId == id).toList(),
          'undonePlaces2Patrol':
              undonePlaces2Patrol.where((upp) => upp.customerId == id).toList(),
        };
        result.add(place2patrol);
      }
      return result;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('今日巡邏紀錄'),
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: _places2PatrolGroupByCustomer.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.only(
            top: index == 0 ? 8 : 24,
            left: 16,
            right: 16,
            bottom: index == _places2PatrolGroupByCustomer.length - 1 ? 24 : 0,
          ),
          child: index == 0
              ? PatrolRecordWidget(
                  donePlaces2Patrol: _places2PatrolGroupByCustomer[index]
                      ['donePlaces2Patrol']!,
                  undonePlaces2Patrol: _places2PatrolGroupByCustomer[index]
                      ['undonePlaces2Patrol']!,
                )
              : PatrolRecordWidget(
                  donePlaces2Patrol: _places2PatrolGroupByCustomer[index]
                      ['donePlaces2Patrol']!,
                  undonePlaces2Patrol: _places2PatrolGroupByCustomer[index]
                      ['undonePlaces2Patrol']!,
                  enabled: false,
                ),
        ),
      ),
    );
  }
}

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('今日巡邏紀錄'),
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(
          top: 8,
          left: 16,
          right: 16,
          bottom: 24,
        ),
        child: PatrolRecordWidget(
          donePlaces2Patrol: donePlaces2Patrol,
          undonePlaces2Patrol: undonePlaces2Patrol,
        ),
      ),
    );
  }
}

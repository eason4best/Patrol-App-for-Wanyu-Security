import 'package:flutter/material.dart';
import 'package:security_wanyu/model/place2patrol.dart';

class ShiftCustomerWidget extends StatelessWidget {
  final List<Place2Patrol> places2Patrol;

  const ShiftCustomerWidget({
    super.key,
    required this.places2Patrol,
  });

  List<Map<String, String>> _getCustomersAndShiftTimes() {
    List<int> customerIds =
        Set<int>.from(places2Patrol.map((pp) => pp.customerId)).toList();
    List<Map<String, String>> results = [];
    for (var id in customerIds) {
      Place2Patrol pp = places2Patrol.firstWhere((pp) => pp.customerId == id);
      results.add({
        'customerName': pp.customerName!,
        'shiftTime': pp.shiftTime!,
      });
    }
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      elevation: 4.0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: places2Patrol.isNotEmpty
          ? ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0.0),
              itemBuilder: (context, index) => ListTile(
                title:
                    Text(_getCustomersAndShiftTimes()[index]['customerName']!),
                trailing:
                    Text(_getCustomersAndShiftTimes()[index]['shiftTime']!),
              ),
              separatorBuilder: (context, index) => const Divider(
                height: 0,
                thickness: 1,
              ),
              itemCount: _getCustomersAndShiftTimes().length,
            )
          : SizedBox(
              height: 48,
              child: Center(
                  child: Text(
                '本日無執勤',
                style: Theme.of(context).textTheme.subtitle1,
              )),
            ),
    );
  }
}

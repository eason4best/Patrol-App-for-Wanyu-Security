import 'package:flutter/material.dart';

class ShiftCustomerWidget extends StatelessWidget {
  final List<String> dayShiftCustomers;

  const ShiftCustomerWidget({
    super.key,
    required this.dayShiftCustomers,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      elevation: 4.0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: dayShiftCustomers.isNotEmpty
          ? ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => ListTile(
                title: Text(dayShiftCustomers[index]),
              ),
              separatorBuilder: (context, index) => const Divider(
                height: 0,
                thickness: 1,
              ),
              itemCount: dayShiftCustomers.length,
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

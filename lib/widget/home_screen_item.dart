import 'package:flutter/material.dart';

class HomeScreenItem extends StatelessWidget {
  final String title;
  final Icon icon;
  const HomeScreenItem({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: icon,
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                title,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

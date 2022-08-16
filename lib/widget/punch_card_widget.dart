import 'package:flutter/material.dart';

class PunchCardWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const PunchCardWidget({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        margin: const EdgeInsets.all(0),
        elevation: 4.0,
        child: SizedBox(
          width: (MediaQuery.of(context).size.width - 24 * 2 - 30 * 2) / 3,
          height: 56,
          child: Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ),
      ),
    );
  }
}

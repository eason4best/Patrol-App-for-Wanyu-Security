import 'package:flutter/material.dart';

class MainFunctionWidget extends StatelessWidget {
  final String title;
  final Icon icon;
  final VoidCallback onPressed;
  const MainFunctionWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        margin: const EdgeInsets.all(0),
        elevation: 4.0,
        child: Column(
          children: [
            Expanded(
              flex: 2,
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
      ),
    );
  }
}

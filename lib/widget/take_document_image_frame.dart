import 'package:flutter/material.dart';

class TakeDocumentImageFrame extends StatelessWidget {
  final double documentAspectRatio;
  const TakeDocumentImageFrame({
    Key? key,
    required this.documentAspectRatio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.width * 0.8 / documentAspectRatio,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 3.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}

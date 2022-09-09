import 'package:flutter/material.dart';

class EtunLogo extends StatelessWidget {
  const EtunLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/logo.png',
          width: 200,
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            '萬宇保全',
            style: Theme.of(context).textTheme.headline4!.copyWith(
                color: const Color(0xff72716f),
                fontWeight: FontWeight.bold,
                letterSpacing: 16.0,
                shadows: [
                  const Shadow(
                    color: Colors.black12,
                    offset: Offset(2, 2),
                    blurRadius: 4,
                  ),
                ]),
          ),
        )
      ],
    );
  }
}

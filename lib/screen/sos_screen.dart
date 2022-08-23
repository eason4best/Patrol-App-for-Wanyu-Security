import 'package:flutter/material.dart';
import 'package:security_wanyu/enum/sos_number.dart';
import 'package:url_launcher/url_launcher.dart';

class SOSScreen extends StatelessWidget {
  const SOSScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('緊急聯絡'),
      ),
      body: ListView(
        children: List.generate(
          SOSNumber.values.length,
          (index) => ListTile(
            title: Text(SOSNumber.values[index].toString()),
            subtitle: Text(SOSNumber.values[index].getNumber()),
            onTap: () async {
              final Uri launchUri = Uri(
                scheme: 'tel',
                path: SOSNumber.values[index].getNumber(),
              );
              await launchUrl(launchUri);
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:security_wanyu/service/sos_numbers.dart';
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
        children: [
          ListTile(
            title: Text(
              '台南地區',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          ...List.generate(
            SOSNumber().tainanSOSNumber.length,
            (index) => ListTile(
              title: Text(SOSNumber().tainanSOSNumber[index].keys.first),
              subtitle: Text(SOSNumber().tainanSOSNumber[index].values.first),
              onTap: () async {
                final Uri launchUri = Uri(
                  scheme: 'tel',
                  path: SOSNumber().tainanSOSNumber[index].values.first,
                );
                await launchUrl(launchUri);
              },
            ),
          ),
          ListTile(
            title: Text(
              '雲嘉地區',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          ...List.generate(
            SOSNumber().yunChiaSOSNumber.length,
            (index) => ListTile(
              title: Text(SOSNumber().yunChiaSOSNumber[index].keys.first),
              subtitle: Text(SOSNumber().yunChiaSOSNumber[index].values.first),
              onTap: () async {
                final Uri launchUri = Uri(
                  scheme: 'tel',
                  path: SOSNumber().yunChiaSOSNumber[index].values.first,
                );
                await launchUrl(launchUri);
              },
            ),
          ),
        ],
      ),
    );
  }
}

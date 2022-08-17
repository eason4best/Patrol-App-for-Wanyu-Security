import 'package:flutter/material.dart';
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
            title: const Text('緊急電話1'),
            subtitle: const Text('0912345678'),
            onTap: () async {
              final Uri launchUri = Uri(
                scheme: 'tel',
                path: '0912345678',
              );
              await launchUrl(launchUri);
            },
          ),
          ListTile(
            title: const Text('緊急電話2'),
            subtitle: const Text('0987654321'),
            onTap: () async {
              final Uri launchUri = Uri(
                scheme: 'tel',
                path: '0987654321',
              );
              await launchUrl(launchUri);
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:security_wanyu/enum/contact_us.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('聯絡我們'),
      ),
      body: ListView.builder(
        itemCount: ContactUs.values.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(ContactUs.values[index].toString()),
          subtitle: Text('透過${ContactUs.values[index].toString()}聯繫、意見反應'),
          leading: Icon(
            ContactUs.values[index] == ContactUs.phone
                ? Icons.phone_outlined
                : Icons.email_outlined,
          ),
          onTap: () async {
            if (ContactUs.values[index] == ContactUs.phone) {
              final Uri launchUri = Uri(
                scheme: 'tel',
                path: '063565596',
              );
              await launchUrl(launchUri);
            } else {
              final Uri emailLaunchUri = Uri(
                scheme: 'mailto',
                path: 'etungroup@gmail.com',
              );
              launchUrl(emailLaunchUri);
            }
          },
        ),
      ),
    );
  }
}

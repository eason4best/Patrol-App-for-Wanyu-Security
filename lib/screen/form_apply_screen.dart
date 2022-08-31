import 'package:flutter/material.dart';
import 'package:security_wanyu/enum/forms.dart';
import 'package:security_wanyu/model/member.dart';
import 'package:security_wanyu/screen/leave_form_screen.dart';
import 'package:security_wanyu/screen/resign_form_screen.dart';

class FormApplyScreen extends StatelessWidget {
  final Member member;
  const FormApplyScreen({Key? key, required this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('表單申請'),
      ),
      body: ListView.builder(
        itemCount: Forms.values.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(Forms.values[index].toString()),
          onTap: () => Forms.values[index] == Forms.leave
              ? Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LeaveFormScreen.create(member: member)))
              : Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ResignFormScreen.create(member: member))),
        ),
      ),
    );
  }
}
